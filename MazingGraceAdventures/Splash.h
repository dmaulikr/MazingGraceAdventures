//
//  Splash.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 3/27/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** Splash screen */
@interface Splash : CCLayer {
    BOOL started;
}

/** Gets a scene for this layer */
+ (CCScene*) scene;

/** Make automatic transition to the main screen */
-(void) makeTransition:(ccTime)dt;

/** Makes transition to main screen on button click */
-(void) onGo: (CCMenuItemFont*) button;
@end
