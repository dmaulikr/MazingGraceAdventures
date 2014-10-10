//
//  SoundEffects.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/** Convenience rapper (pun intended) of sound effects */
@interface SoundEffects : NSObject

/** Preloads the sounds; failure to invoke this method may
 cause a lag in the initial playback of an effect. */
+ (void) preload;

/** Worker thread to preload the sound effects in a background. */
+ (void) worker;

/** Plays a random yeah */
+ (void) yeah;

/** Plays a random boo */
+ (void) boo;

/** Plays a big sound */
+ (void) big;

/* Plays a lil sound */
+ (void) lil;

/** Plays done sound */
+ (void) done;

/** Plays a random cheer */
+ (void) cheer;

/* Plays a random disappoinment */
+ (void) disappoint;
@end
