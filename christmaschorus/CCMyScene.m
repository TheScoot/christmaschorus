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
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);

        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        background.zPosition = 0;
        
        CCPlayer *drummer = [[CCPlayer alloc] initWithPlayerNamed:@"drummer"];
        drummer.position = CGPointMake(CGRectGetMidX(self.frame) - drummer.size.width, CGRectGetMidY(self.frame));
        drummer.zPosition = 1;
        drummer.position = CGPointMake(110,-63);
        [self addChild:drummer];

        CCPlayer *guitar = [[CCPlayer alloc] initWithPlayerNamed:@"guitar"];
        guitar.position = CGPointMake(CGRectGetMidX(self.frame) + guitar.size.width, CGRectGetMidY(self.frame));
        guitar.zPosition = 1;
        guitar.position = CGPointMake(-58,-47);
        [self addChild:guitar];

        CCPlayer *piano = [[CCPlayer alloc] initWithPlayerNamed:@"piano"];
        piano.position = CGPointMake(CGRectGetMidX(self.frame) + piano.size.width, CGRectGetMidY(self.frame));
        piano.zPosition = 1;
        piano.position = CGPointMake(290,-54);
        [self addChild:piano];
        
        CCPlayer *singer = [[CCPlayer alloc] initWithPlayerNamed:@"singer"];
        singer.position = CGPointMake(CGRectGetMidX(self.frame) + singer.size.width, CGRectGetMidY(self.frame));
        singer.zPosition = 1;
        singer.position = CGPointMake(-257,-42);
        [self addChild:singer];

        //pre-load partical effects
        NSString *myParticlePath = [[NSBundle mainBundle] pathForResource:@"snowing" ofType:@"sks"];
        snowPartical = [NSKeyedUnarchiver unarchiveObjectWithFile:myParticlePath];
        snowPartical.particlePosition = CGPointMake(0, (self.frame.size.height/2));
        snowPartical.zPosition = 0;
        [self addChild:snowPartical];
        
        //start playing the song
        [drummer startPlaying];
        [guitar startPlaying];
        [piano startPlaying];
        [singer startPlaying];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];

        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
