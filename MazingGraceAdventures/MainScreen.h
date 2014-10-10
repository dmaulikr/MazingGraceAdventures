//
//  MainScreen.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Entity.h"

/** Main screen */
@interface MainScreen : CCLayer {
    int screenWidth;
    int screenHeight;
}

/** Gets a scene for this layer */
+(CCScene *) scene;

/** Constructor */
-(id) init;

/* Handles start when the player starts the game */
-(void) onStart: (CCMenuItemFont*) button;

/** Handles quit when the player quits the game */
-(void) onQuit: (CCMenuItemFont*) button;

/** Handles credits */ 
-(void) onCredits: (CCMenuItemFont*) button;
@end
