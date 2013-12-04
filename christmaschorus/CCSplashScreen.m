//
//  CCSplashScreen.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/18/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCSplashScreen.h"
#import "CCMyScene.h"

@implementation CCSplashScreen{
    CCMyScene *mainScene;
    float deviceScale;
    AVAudioPlayer *avPlayer;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            deviceScale = 0.4f;
        } else {
            deviceScale = 1.0f;
        }

//        NSError* err;
//        //Initialize our player
//        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"introtrack" ofType:@"aif"];
//        avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
//        if( err ){
//            //bail!
//            NSLog(@"Failed with reason: %@", [err localizedDescription]);
//        } else {
//            [avPlayer prepareToPlay];
//        }
        
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splashscreenbg"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        background.zPosition = 0;
        //background.scale = deviceScale;

        //get the santa animation ready
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"santa"];
        NSArray *animationFrames = [NSArray arrayWithObjects:@"laying1",
                                    @"laying2",
                                    @"laying3",
                                    @"laying4",
                                    @"laying5",
                                    @"laying6",
                                    @"laying7",
                                    @"laying8",
                                    @"laying7",
                                    @"laying6",
                                    @"laying5",
                                    @"laying4",
                                    @"laying3",
                                    @"laying2",
                                    @"laying1",
                                    nil];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:animationFrames.count];
        for (int i=0; i<animationFrames.count; i++) {
            SKTexture *animationTex = [atlas textureNamed:animationFrames[i]];
            [frames addObject:animationTex];
        }
        //build the animation for playing instrument
        SKAction *layingAction = [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:0.2]];

        //Put the title stuff together
        SKNode *title = [SKNode node];
        
        SKSpriteNode *santa = [SKSpriteNode spriteNodeWithImageNamed:@"laying1"];
        santa.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50);
        [title addChild:santa];
        santa.zPosition = 2;
        [santa runAction:layingAction];

        SKSpriteNode *titleCardTop = [SKSpriteNode spriteNodeWithImageNamed:@"titletop"];
        titleCardTop.position = CGPointMake(CGRectGetMidX(self.frame), (santa.frame.size.height / 2) + 100);
        [title addChild:titleCardTop];
        titleCardTop.zPosition = 1;
        
        SKSpriteNode *titleCardBottom = [SKSpriteNode spriteNodeWithImageNamed:@"titlebottom"];
        titleCardBottom.position = CGPointMake(CGRectGetMidX(self.frame), -(santa.frame.size.height / 2) - 100);
        [title addChild:titleCardBottom];
        titleCardBottom.zPosition = 1;
        
        title.scale = deviceScale;
        [background addChild:title];
        
        mainScene = [[CCMyScene alloc] initWithSize:self.size];
        

    }
    
    return self;
}

//-(void) willMoveFromView:(SKView *)view{
//    [avPlayer stop];
//}
//
//-(void) didMoveToView:(SKView *)view{
//    [avPlayer play];
//}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition fadeWithDuration:2.0];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        mainScene.scaleMode = SKSceneScaleModeAspectFit;
    } else {
        mainScene.scaleMode = SKSceneScaleModeAspectFill;
    }
    [self.scene.view presentScene: mainScene transition: reveal];
    [mainScene showScene];
}
@end
