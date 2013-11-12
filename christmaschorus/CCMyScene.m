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
        CCPlayer *drummer = [[CCPlayer alloc] initWithPlayerNamed:@"drummer"];
        [self addChild:drummer];
        CCPlayer *guitar = [[CCPlayer alloc] initWithPlayerNamed:@"guitar"];
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
