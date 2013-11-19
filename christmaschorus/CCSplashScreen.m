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
    }
    
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
    CCMyScene *newScene = [[CCMyScene alloc] initWithSize: CGSizeMake(1024,768)];
    [self.scene.view presentScene: newScene transition: reveal];
    
}
@end
