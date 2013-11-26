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
    NSTimer *randomThrowTimer;
    SKSpriteNode *throwingElf;
    UITapGestureRecognizer* tapOnce;
}

-(id)init{
    self = [super initWithImageNamed:@"elf-hidden"];
    
    if(self){
        self.userInteractionEnabled = YES;

        allowThrowing = YES;
        
        //get the throwing animation ready
        throwingElf = [SKSpriteNode spriteNodeWithImageNamed:@"elfstart"];
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
        
        self.position = CGPointMake(0, 100);
        [self resetRandomThrowTimer];
        NSLog(@"bounding Box after loading = %@", NSStringFromCGRect(self.frame));
        [self debugBox:self.frame];
    }
    
    return self;
}


-(void) throwRandomSnowball{
    [self throwSnowball];
}

-(void) resetRandomThrowTimer{
    //first kill any timer already running
    [randomThrowTimer invalidate];
    //throw at a random time from now but at least 10 more seconds
    int nextThrow = arc4random_uniform(20) + 10;
    randomThrowTimer = [NSTimer scheduledTimerWithTimeInterval:nextThrow target:self selector:@selector(throwRandomSnowball) userInfo:nil repeats:NO];
}


-(void) throwSnowball{
    NSLog(@"bounding Box before throw = %@", NSStringFromCGRect(self.frame));
    if(!self.hasActions && allowThrowing == YES){
        allowThrowing = NO;
        self.alpha = 0.0f;
        throwingElf.position = CGPointMake(self.position.x - 82, self.position.y - 117);
        [self.parent addChild:throwingElf];
        [throwingElf runAction:throwingAction completion:^{ [self removeSnowball]; }];
    }
    [self resetRandomThrowTimer];
}

-(void) hideElf{
    [throwingElf removeAllActions];
    [throwingElf removeFromParent];
    throwingElf.texture = hiddenTexture;
    throwingElf.scale = 1.0;
    self.zPosition = 1000;
    float newX = arc4random_uniform((self.parent.frame.size.width) - 100) - ((self.parent.frame.size.width / 2) + 20);
    float newY = arc4random_uniform(50) + 80;
    self.alpha = 1.0f;
    self.position = CGPointMake(newX, newY);
    NSLog(@"new Pos = %@", NSStringFromCGPoint(self.position));
    allowThrowing = YES;
    NSLog(@"bounding Box after moving elf = %@", NSStringFromCGRect(self.frame));
    [self debugBox:self.frame];
}

-(void)removeSnowball{
    [throwingElf runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5f],[SKAction group:@[[SKAction moveToY:-(self.parent.frame.size.height) duration:1.5f], [SKAction scaleBy:0.25f duration:1.5f]]]]] completion:^{ [self hideElf];     allowThrowing = YES; }];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Touched my elf!");
    [self throwSnowball];
}

-(void) debugBox:(CGRect)theRect {
    
    SKShapeNode*  pathShape = [[SKShapeNode alloc] init];
    CGPathRef thePath = CGPathCreateWithRect( theRect, NULL);
    pathShape.path = thePath;
    
    pathShape.lineWidth = 1;
    pathShape.strokeColor = [SKColor greenColor];
    pathShape.position = CGPointMake( 0, 0);
    
    [self.parent addChild:pathShape];
    pathShape.zPosition = 1000;
    
}
@end
