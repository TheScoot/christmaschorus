//
//  CCPlayer.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "CCPlayer.h"

@implementation CCPlayer{
    AVAudioPlayer *avPlayer;
}

-(id) initWithPlayerNamed:(NSString *) player{
    self = [super initWithImageNamed:player];

    if(self){
        self.userInteractionEnabled = YES;
        [self loadAVPlayerForInstument:player];
    }
    
    return self;
}

-(void) loadAVPlayerForInstument:(NSString *)instrument{
    NSString *resourcePath;
    NSError* err;

    //Initialize our DRUM player
    resourcePath = [[NSBundle mainBundle] pathForResource:instrument ofType:@"aif"];
    avPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:resourcePath] error:&err];
    if( err ){
        //bail!
        NSLog(@"Failed with reason: %@", [err localizedDescription]);
    }
}

-(void) startPlaying{
    [avPlayer play];
}

-(void) toggleVolume{
    if(avPlayer.volume == 0.0){
        [avPlayer setVolume:1.0];
    } else {
        [avPlayer setVolume:0.0];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */

    [self toggleVolume];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
    }
}
@end
