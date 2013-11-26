//
//  CCElf.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/25/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCElf.h"

@implementation CCElf{
    SKAction *throwingAction;
    bool allowThrowing;
    SKTexture *hiddenTexture;
    CGPoint originalPosition;
}

-(id)init{
    self = [super initWithImageNamed:@"elfstart"];
    
    if(self){
        self.userInteractionEnabled = YES;

        hiddenTexture = [SKTexture textureWithImageNamed:@"elfstart"];
        
        allowThrowing = YES;
        
        //get the popping animation ready
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"elf"];
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:26];
        for (int i=1; i<=24; i++) {
            SKTexture *animationTex = [atlas textureNamed:[NSString stringWithFormat:@"elf%d", i]];
            [frames addObject:animationTex];
        }
        //build the animation for playing instrument
        throwingAction = [SKAction animateWithTextures:frames timePerFrame:1.0];
        
        originalPosition = self.position;
    }
    
    return self;
}

-(void) setPosition:(CGPoint)position{
    [super setPosition:position];
    originalPosition = position;
}

-(void) throw{
    if(!self.hasActions && allowThrowing == YES){
        allowThrowing = NO;
        [self runAction:throwingAction completion:^{ [self removeSnowball]; }];
    }
}

-(void) hideElf{
    self.position = originalPosition;
    self.texture = hiddenTexture;
    self.scale = 1.0;
    allowThrowing = YES;
}

-(void)removeSnowball{
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5f],[SKAction group:@[[SKAction moveToY:-(self.parent.frame.size.height) duration:1.5], [SKAction scaleBy:0.25f duration:1.5]]]]] completion:^{ [self hideElf];     allowThrowing = YES; }];
    //[self hideElf];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self throw];
}
@end
