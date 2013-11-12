//
//  CCMyScene.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCMyScene.h"
#import "CCPlayer.h"

@implementation CCMyScene


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        //get the coordinates of the scene the same as all the sprites
        self.anchorPoint = CGPointMake(0.5,0.5);

        CCPlayer *drummer = [[CCPlayer alloc] initWithPlayerNamed:@"drummer"];
        drummer.position = CGPointMake(CGRectGetMidX(self.frame) - drummer.size.width, CGRectGetMidY(self.frame));
        [self addChild:drummer];
        CCPlayer *guitar = [[CCPlayer alloc] initWithPlayerNamed:@"guitar"];
        guitar.position = CGPointMake(CGRectGetMidX(self.frame) + guitar.size.width, CGRectGetMidY(self.frame));
        [self addChild:guitar];
        
        //start playing the song
        [drummer startPlaying];
        [guitar startPlaying];
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
