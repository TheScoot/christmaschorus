//
//  CCElf.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/25/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCElf.h"
#import "SKSpriteNode+debug.h"

@implementation CCElf{
    SKAction *throwingAction;
    bool allowThrowing;
    SKTexture *hiddenTexture;
    NSTimer *randomThrowTimer;
    SKSpriteNode *throwingElf;
    float elfScale;
}

-(id)init{
    self = [super initWithImageNamed:@"elf-hidden"];
    
    if(self){
        //[self showZposition];
        //[self showParent];
        //[self showDebugBox];
        
        self.userInteractionEnabled = YES;

        allowThrowing = YES;
        
        //get the throwing animation ready
        throwingElf = [SKSpriteNode spriteNodeWithImageNamed:@"elfstart"];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            self.scale = 0.5f;
            elfScale = 0.5f;
            throwingElf.scale = elfScale;
            self.position = CGPointMake(0, 10);
        } else {
            self.scale = 1.0f;
            elfScale = 1.0f;
            throwingElf.scale = elfScale;
            self.position = CGPointMake(0, 120);
        }
        throwingElf.zPosition = 1000;
        hiddenTexture = [SKTexture textureWithImageNamed:@"elfstart"];
        //SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"elf"];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:26];
        for (int i=1; i<=24; i++) {
            SKTexture *animationTex = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"elf%d", i]];
            [frames addObject:animationTex];
        }
        //build the animation for playing instrument
        throwingAction = [SKAction animateWithTextures:frames timePerFrame:0.075];
        
        [self resetRandomThrowTimer];
    }
    
    return self;
}


-(void) resetRandomThrowTimer{
    //first kill any timer already running
    [randomThrowTimer invalidate];
    //throw at a random time from now but at least 10 more seconds
    int nextThrow = arc4random_uniform(20) + 10;
    randomThrowTimer = [NSTimer scheduledTimerWithTimeInterval:nextThrow target:self selector:@selector(throwSnowball) userInfo:nil repeats:NO];
}


-(void) throwSnowball{
    if(!self.hasActions && allowThrowing == YES){
        allowThrowing = NO;
        self.alpha = 0.0f;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
            throwingElf.position = CGPointMake(self.position.x - 43, self.position.y - 64);
        } else {
            throwingElf.position = CGPointMake(self.position.x - 82, self.position.y - 117);
        }
        [self.parent addChild:throwingElf];
        [throwingElf runAction:throwingAction completion:^{ [self removeSnowball]; }];
    }
    [self resetRandomThrowTimer];
}

-(void) hideElf{
    [throwingElf removeAllActions];
    [throwingElf removeFromParent];
    throwingElf.texture = hiddenTexture;
    throwingElf.scale = elfScale;
    float newX;
    float newY;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        newX = arc4random_uniform((self.parent.frame.size.width) - 50) - ((self.parent.frame.size.width / 2)) + 25;
        newY = arc4random_uniform(24) + 10;
    } else {
        newX = arc4random_uniform((self.parent.frame.size.width) - 50) - ((self.parent.frame.size.width / 2)) + 25;
        newY = arc4random_uniform(50) + 90;
        //commented out code will help test boundaries
        //newX = ((self.parent.frame.size.width) - 50) - (self.parent.frame.size.width / 2) + 25;
        //newX = 0 - (self.parent.frame.size.width / 2) + 25;
        //newY = 50+90;
    }
    self.alpha = 1.0f;
    self.position = CGPointMake(newX, newY);
    allowThrowing = YES;
    //[self showDebugBox];
}

-(void)removeSnowball{
    [throwingElf runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5f],[SKAction group:@[[SKAction moveToY:-(self.parent.frame.size.height) duration:1.5f], [SKAction scaleTo:0.10f duration:1.5f]]]]] completion:^{ [self hideElf];     allowThrowing = YES; }];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self throwSnowball];
}

@end
