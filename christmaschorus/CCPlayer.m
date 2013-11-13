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
    bool debugMode;
    SKLabelNode *debugLabel;
}

-(id) initWithPlayerNamed:(NSString *) player{
    self = [super initWithImageNamed:player];

    if(self){
        self.userInteractionEnabled = YES;
        [self loadAVPlayerForInstument:player];
        
        debugLabel = [SKLabelNode labelNodeWithFontNamed:@"helvetica"];
        [self addChild:debugLabel];
        
        self.scale = 0.75f;

        self.color = [SKColor blackColor];
        self.colorBlendFactor = 0.0;

        debugMode = YES;
    }
    
    return self;
}

-(void) loadAVPlayerForInstument:(NSString *)instrument{
    NSString *resourcePath;
    NSError* err;

    //Initialize our DRUM player
    resourcePath = [[NSBundle mainBundle] pathForResource:instrument ofType:@"aif"];
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
    if( err ){
        //bail!
        NSLog(@"Failed with reason: %@", [err localizedDescription]);
    }
}

-(void) startPlaying{
    [avPlayer play];
}

-(void) togglePlaying{
    if(avPlayer.volume == 0.0){
        [avPlayer setVolume:1.0];
        self.colorBlendFactor = 0.0;
    } else {
        [avPlayer setVolume:0.0];
        self.colorBlendFactor = 0.75;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    [self togglePlaying];
    
    //get the touch info
	UITouch *touch = [touches anyObject];
    //where did the user touch
	CGPoint positionInScene = [touch locationInNode:self.parent];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
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
