//
//  Credits.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** Credits screen */
@interface Credits : CCLayer

/** Gets a scene for this layer */
+(CCScene *) scene;

/** Constructor */
- (id) init;

/** Handles back */
- (void) onBack: (CCMenuItemFont*) button;
@end