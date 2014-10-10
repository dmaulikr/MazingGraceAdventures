//
//  Complete.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** Complete screen */
@interface Complete : CCLayer

/** Gets a scene for this layer */
+ (CCScene*) scene;

/** Constructor */
- (id) init;

/** Handles continue when the player wins */
- (void) onContinue: (CCMenuItemFont*) button;
@end
