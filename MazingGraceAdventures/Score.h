//
//  Score.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** Convenience class for managing scores */
@interface Score : CCLayer {
    CCLabelTTF* label;
}

/** Gets the score */
+ (int) score;

/** Increments the score */
+ (void) increment:(int)amount;

/** Constructor */
- (id) initAt:(CGPoint) point;

/** Updates the score */
- (void) update;
@end
