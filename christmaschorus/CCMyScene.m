//
//  CCMyScene.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCMyScene.h"
#import "CCPlayer.h"
#import "CCElf.h"

@implementation CCMyScene{
    SKEmitterNode *snowPartical;
    NSArray *chorusDictArray;
    NSMutableArray *chorus;
    SKSpriteNode *background;
}


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);
        
        background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        background.zPosition = 0;

        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"blinking"];
        NSArray *animationFrames = [NSArray arrayWithObjects:@"blinking1.png",
                                    @"blinking2.png",
                                    @"blinking3.png",
                                    @"blinking4.png",
                                    @"blinking5.png",
                                    nil];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:animationFrames.count];
        for (int i=0; i<animationFrames.count; i++) {
            SKTexture *animationTex = [atlas textureNamed:animationFrames[i]];
            [frames addObject:animationTex];
        }
        //build the animation for blinking the lights
        SKAction *lightsBlinking = [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:0.5f]];
        SKSpriteNode *lights = [SKSpriteNode spriteNodeWithImageNamed:@"lightson"];
        lights.position = CGPointMake(CGRectGetMidX(self.frame), ((self.frame.size.height / 2) - lights.size.height / 2));
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
        //[self addChild:snowPartical];

        //walk the chorus out onto the stage
        chorus = [NSMutableArray arrayWithCapacity:chorusDictArray.count];
        for (NSDictionary *chorusData in chorusDictArray) {
            CCPlayer *newChorus = [[CCPlayer alloc] initWithDictionary:chorusData];
            //newChorus.zPosition = 1;
            //newChorus.position = CGPointFromString(chorusData[@"position"]);
            [self addChild:newChorus];
            [chorus addObject:newChorus];
        }
    }
    
    return self;
}

-(void) showScene{
    //start playing the song
    for (CCPlayer *chorusPlayer in chorus){
        [chorusPlayer startPlaying];
    }
    //add in a dirty elf to start throwing snowballs
    CCElf *dirtyElf;
    dirtyElf = [[CCElf alloc] init];
    [background addChild:dirtyElf];
    dirtyElf.zPosition = 1000;
}

#pragma mark - helper functions
-(NSDictionary *) loadPlistData{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"GameData.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    return plistData;
}

@end
