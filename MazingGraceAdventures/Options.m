//
//  Options.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Options.h"

#define UD_KEY_SOUNDS @"mga.sounds"
#define UD_KEY_MUSIC @"mga.music"

static NSUserDefaults* userDefaults = nil;

@implementation Options

+ (bool) soundsOn {
    [Options loadDefaults];
    
    BOOL soundsEnabled = [userDefaults boolForKey:UD_KEY_SOUNDS];
    
	return soundsEnabled;
}

+ (void) enableSounds: (bool) toggle {
    [Options loadDefaults];
    
    [userDefaults setBool:toggle forKey:UD_KEY_SOUNDS];
}

+ (bool) musicOn {
    [Options loadDefaults];
    
	bool musicOn = [userDefaults boolForKey:UD_KEY_MUSIC];
    
    return musicOn;
}

+ (void) enableMusic: (bool) toggle {
    [Options loadDefaults];
    
    [userDefaults setBool:toggle forKey:UD_KEY_MUSIC];
}

+ (void) loadDefaults {
    if(userDefaults == nil)
        userDefaults = [[NSUserDefaults alloc] init];    
}
@end
