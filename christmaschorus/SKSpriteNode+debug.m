//
//  SKSpriteNode+debug.m
//  christmaschorus
//
//  Created by Scott Bedard on 11/26/13.
//  Copyright (c) 2013 Scott Bedard. All rights reserved.
//

#import "SKSpriteNode+debug.h"

@implementation SKSpriteNode (debug)

-(void) showZposition{
    SKLabelNode *debugLabel = [SKLabelNode labelNodeWithFontNamed:@"helvetica"];
    debugLabel.zPosition = 100000;
    debugLabel.position = CGPointMake(0, 0);
    debugLabel.text = [NSString stringWithFormat:@"%f", self.zPosition];
    [self addChild:debugLabel];
    NSLog(@"class %@ is at %f", self.name, self.zPosition);
}

-(void) showParent{
    SKLabelNode *debugLabel = [SKLabelNode labelNodeWithFontNamed:@"helvetica"];
    debugLabel.zPosition = 100000;
    debugLabel.position = CGPointMake(0, 0);
    debugLabel.text = [NSString stringWithFormat:@"%@", self.parent.name];
    [self addChild:debugLabel];
    NSLog(@"class %@ has a parent of %@", self.name, self.parent.class);
}

-(void) showDebugBox {
    CGRect theRect = self.frame;
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
