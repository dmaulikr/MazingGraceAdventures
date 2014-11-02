//
//  GameOver.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** Game over screen */
@interface GameOver : CCLayerColor

/** Gets a scene for this layer */
+ (CCScene*) scene;

/** Constructor */
- (id) init;

/** Handles continue when the player looses */
- (void) onContinue: (CCMenuItemFont*) button;
@end
