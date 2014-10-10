//
//  SoundEffects.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/7/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SoundEffects.h"
#import "SimpleAudioEngine.h"
#import "Options.h"

static NSArray* others;
static NSArray* yeahs;
static NSArray* boos;

@implementation SoundEffects

+ (void) lil {
    if([Options soundsOn])
        [[SimpleAudioEngine sharedEngine] playEffect:@"blip2.mp3"];
}

+ (void) big {
    if([Options soundsOn])
        [[SimpleAudioEngine sharedEngine] playEffect:@"bonus.mp3"];
}

+ (void) done {
    if([Options soundsOn])
        [[SimpleAudioEngine sharedEngine] playEffect:@"shazam2.mp3"];
}

+ (void) yeah {
    if(![Options soundsOn])
        return;
    
    int sz = [yeahs count];
    
    int lottery = rand() % sz;
    
    [[SimpleAudioEngine sharedEngine] playEffect:[yeahs objectAtIndex:lottery]];
}

+ (void) boo {
    if(![Options soundsOn])
        return;
    
    int sz = [boos count];
    
    int lottery = rand() % sz;
    
    [[SimpleAudioEngine sharedEngine] playEffect:[boos objectAtIndex:lottery]];    
}

+ (void) cheer {
    if([Options soundsOn])
        [[SimpleAudioEngine sharedEngine] playEffect:@"cheer2.mp3"];
}

+ (void) disappoint {
    if([Options soundsOn])
        [[SimpleAudioEngine sharedEngine] playEffect:@"aaaah.mp3"];
}

+ (void) preload {
//    [self worker];
    [NSThread detachNewThreadSelector:@selector(worker)
                             toTarget:self
                           withObject:nil];
}

+ (void) worker {   
    // Preload the sound effects
    others = [[NSArray alloc] initWithObjects:
            @"blip2.mp3", 
            @"shazam2.mp3",
            @"bonus.mp3", 
            nil];
    
    for(NSString* effect in others)
        [[SimpleAudioEngine sharedEngine] preloadEffect:effect]; 
    
    yeahs = [[NSArray alloc] initWithObjects:
             @"yummy2.mp3",
             @"you-got-it-1.mp3",
             @"you-can-do-it.mp3",
             @"wow.mp3",
             nil];
    
    boos = [[NSArray alloc] initWithObjects:
            @"evil-laf.mp3",
            @"you-need-to-grow-up.mp3",
            nil];
    
    for(NSString* effect in yeahs)
        [[SimpleAudioEngine sharedEngine] preloadEffect:effect]; 
    
    for(NSString* effect in boos)
        [[SimpleAudioEngine sharedEngine] preloadEffect:effect];
}
@end
