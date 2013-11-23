//
//  CCSplashScreen.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/18/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCSplashScreen.h"
#import "CCMyScene.h"

@implementation CCSplashScreen

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"splashscreenbg"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        background.zPosition = 0;

        SKSpriteNode *titleCard = [SKSpriteNode spriteNodeWithImageNamed:@"titlecard"];
        titleCard.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:titleCard];
        titleCard.zPosition = 1;

        //get the santa animation ready
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"santa"];
        NSArray *animationFrames = [NSArray arrayWithObjects:@"laying1", @"laying2", @"laying3", @"laying4", @"laying5", @"laying6", @"laying7", @"laying8",
                                   @"laying7", @"laying6", @"laying5", @"laying4", @"laying3", @"laying2", @"laying1", nil];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:animationFrames.count];
        for (int i=0; i<animationFrames.count; i++) {
            SKTexture *animationTex = [atlas textureNamed:animationFrames[i]];
            [frames addObject:animationTex];
        }
        //build the animation for playing instrument
        SKAction *layingAction = [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:0.2]];

        SKSpriteNode *santa = [SKSpriteNode spriteNodeWithImageNamed:@"laying1"];
        santa.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50);
        [self addChild:santa];
        santa.zPosition = 2;
        [santa runAction:layingAction];

    }
    
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
    CCMyScene *newScene = [[CCMyScene alloc] initWithSize: CGSizeMake(1024,768)];
    [self.scene.view presentScene: newScene transition: reveal];
    
}
@end
