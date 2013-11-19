//
//  CCMyScene.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCMyScene.h"
#import "CCPlayer.h"

@implementation CCMyScene{
    SKEmitterNode *snowPartical;
    NSArray *chorusDictArray;
    NSMutableArray *chorus;
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        background.zPosition = 0;

        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"bglights"];
        NSArray *animationFrames = [NSArray arrayWithObjects:@"lights1.png", @"lights2.png", nil];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:animationFrames.count];
        for (int i=0; i<animationFrames.count; i++) {
            SKTexture *animationTex = [atlas textureNamed:animationFrames[i]];
            [frames addObject:animationTex];
        }
        //build the animation for blinking the lights
        SKAction *lightsBlinking = [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:0.5f]];
        SKSpriteNode *lights = [SKSpriteNode spriteNodeWithImageNamed:@"lightson"];
        lights.position = CGPointMake(0, ((background.size.height / 2) - lights.size.height / 2));
        lights.zPosition = 1;
        [background addChild:lights];
        [lights runAction:lightsBlinking];
        
        //load in the plist data
        NSDictionary *plistData = [self loadPlistData];
        
        //get the list of chorus data
        chorusDictArray = [NSArray arrayWithArray:[plistData objectForKey:@"chorus"]];
        
        //see if we are in debug mode
        debugMode = [[plistData objectForKey:@"debugmode"] boolValue];

        //pre-load partical effects
        NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"snowing" ofType:@"sks"];
        snowPartical = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
        snowPartical.particlePosition = CGPointMake(0, (self.frame.size.height/2));
        snowPartical.zPosition = 0;
        [self addChild:snowPartical];

        chorus = [NSMutableArray arrayWithCapacity:chorusDictArray.count];
        for (NSDictionary *chorusData in chorusDictArray) {
            CCPlayer *newChorus = [[CCPlayer alloc] initWithDictionary:chorusData];
            //newChorus.zPosition = 1;
            //newChorus.position = CGPointFromString(chorusData[@"position"]);
            [self addChild:newChorus];
            [chorus addObject:newChorus];
        }
        
        //start playing the song
        for (CCPlayer *chorusPlayer in chorus){
            [chorusPlayer startPlaying];
        }
    }
    
    return self;
}

#pragma mark - helper functions
-(NSDictionary *) loadPlistData{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    return plistData;
}

#pragma mark - touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];

        
    }
}


@end
