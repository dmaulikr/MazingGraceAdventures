//
//  Score.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Score.h"

static int value;

@implementation Score
+ (int) score {
	return value;
}

+ (void) increment: (int) amount {
	value += amount;
}

- (id) initAt:(CGPoint) point {
    if((self = [super init])) {
        label = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:30];

        label.position = ccp(point.x, point.y);

        [label setColor:ccc3(0, 0, 0)];

        [self addChild:label];
    }
    
    return self;
}

- (void) update {
    NSString* text = @"0";
    
    text = [text stringByAppendingString:[NSString stringWithFormat:@"%d",value]];
    
    [label setString:text];
}
@end
