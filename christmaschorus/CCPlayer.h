//
//  CCPlayer.h
//  christmaschorus
//
//  Created by Scott Bedard on 11/11/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CCPlayer : SKSpriteNode

-(id) initWithDictionary:(NSDictionary *) playerDictionary;
-(void) startPlaying;
-(void) togglePlaying;

@end
