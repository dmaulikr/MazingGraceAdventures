//
//  InterLevel.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** The inter-level screen */
@interface InterLevel : CCLayer

/** Gets a scene for this layer */
+ (CCScene*) scene;

/** Constructor */
- (id) init;

/** Handles timeout during the inter-level pause */
- (void) timeout;

/** Handles quit during inter-level */
- (void) onQuit:(CCMenuItemFont*) button;
@end
