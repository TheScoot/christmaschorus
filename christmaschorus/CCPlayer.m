//
//  CCPlayer.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCPlayer.h"

@implementation CCPlayer{
    AVAudioPlayer *avPlayer;
    SKLabelNode *debugLabel;
    SKAction *playingAction;
    SKAction *stoppingAction;
    NSDictionary *playerDict;
    SKTexture *offTexture;
    SKTexture *firstFrame;
}

-(id) initWithDictionary:(NSDictionary *) playerDictionary{
    self = [super initWithImageNamed:[playerDictionary[@"characterName"] stringByAppendingString:@"-off"]];

    if(self){
        self.userInteractionEnabled = YES;

        playerDict = playerDictionary;
        
        [self loadAVPlayerForInstument:playerDict[@"characterName"]];
        
        offTexture = [SKTexture textureWithImageNamed:[playerDict[@"characterName"] stringByAppendingString:@"-off"]];

        debugLabel = [SKLabelNode labelNodeWithFontNamed:@"helvetica"];
        debugLabel.fontColor = [SKColor blackColor];
        [self addChild:debugLabel];
        
        self.position = CGPointFromString([NSString stringWithFormat:@"{%@}",playerDict[@"position"]]);
        self.scale = [playerDict[@"scale"] floatValue];
        self.zPosition = [playerDict[@"zPosition"] integerValue];

        self.color = [SKColor blackColor];
        self.colorBlendFactor = 0.0;

        //get the playing animation ready
        if(playerDict[@"playingAnimationAtlas"]){
            SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:playerDict[@"playingAnimationAtlas"]];
            NSArray *animationFrames = [NSArray arrayWithArray:playerDict[@"playingAnimationFrames"]];
            NSMutableArray *frames = [NSMutableArray arrayWithCapacity:animationFrames.count];
            for (int i=0; i<animationFrames.count; i++) {
                SKTexture *animationTex = [atlas textureNamed:animationFrames[i]];
                if(i == 0) firstFrame = animationTex;
                [frames addObject:animationTex];
            }
            //build the animation for playing instrument
            playingAction = [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:0.2]];
            stoppingAction = [SKAction animateWithTextures:frames timePerFrame:0.1];
        }
    }
    
    return self;
}

-(void) loadAVPlayerForInstument:(NSString *)instrument{
    NSString *resourcePath;
    NSError* err;

    //Initialize our player
    resourcePath = [[NSBundle mainBundle] pathForResource:instrument ofType:@"aif"];
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
    if( err ){
        //bail!
        NSLog(@"Failed with reason: %@", [err localizedDescription]);
    } else {
        [avPlayer prepareToPlay];
    }
}

-(void) startPlaying{
    [avPlayer play];
    [self playingAnimation];
    [avPlayer setVolume:1.0];
}

-(void) togglePlaying{
    if(avPlayer.volume == 0.0){
        [avPlayer setVolume:1.0];
        [self playingAnimation];
    } else {
        [self stopAnimation];
        [avPlayer setVolume:0.0];
    }
}

-(void) playingAnimation{
    if(playingAction){
        self.size = firstFrame.size;
        [self runAction:playingAction];
    }
}

-(void) stopAnimation{
    [self removeAllActions];
    self.texture = offTexture;
    self.size = offTexture.size;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self togglePlaying];

}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //we only want to mave things if we are debugging
    if(!debugMode) return;
    
    //get the touch info
	UITouch *touch = [touches anyObject];
    //where did the user touch
	CGPoint positionInScene = [touch locationInNode:self.parent];

    //show the co-ordinates so we can update th eplist by hand
    if(debugMode == YES){
        debugLabel.text = [NSString stringWithFormat:@"%@", NSStringFromCGPoint(positionInScene)];
    }
    
    //move us to where we touched
    self.position = positionInScene;
}

@end
