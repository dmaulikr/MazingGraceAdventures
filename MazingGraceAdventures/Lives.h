//
//  Lives.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** Lives layer and container of lives info */
@interface Lives : CCLayer 

/** Returns number of remaining lives */
+ (int) remaining;

/** Increments the lives count */
+ (void) increment;

/** Decrement the lives count */
+ (void) decrement;

/** Constructor */
- (id) initAt:(CGPoint) point;

/** Updates the lives */
- (void) update;
@end
