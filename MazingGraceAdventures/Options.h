//
//  Options.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Convenience class for setting / getting game options */
@interface Options : NSObject

/** Returns true if sounds are on */
+ (bool) soundsOn;

/** Returns true if theme music is on */
+ (bool) musicOn;

/** Toggles sounds */
+ (void) enableSounds: (bool) toggle;

/** Toggles music */
+ (void) enableMusic:(bool)toggle;

/** Loads persistent defaults */
+ (void) loadDefaults;
@end
