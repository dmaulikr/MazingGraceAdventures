//
//  Helper.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// Macros to handle retina-pixel conversions: 1x1 retina point is 2x2 pixels.
// See http://stackoverflow.com/questions/9286975/cocos2d-pixels-and-positioning
#define PIXELS_PER_POINT 2.
#define TOPOINT(pix) (pix / PIXELS_PER_POINT)
#define TOPIXEL(pt) (pt * PIXELS_PER_POINT)

/** A class for carrying out various convenience methods */
@interface Helper : NSObject

/** Converts world to tile coordinates */
+ (CGPoint) world: (CCTMXTiledMap*) world toTile: (CGPoint) xy;

/* Converts tile to world coordinates */
+ (CGPoint) tile: (CGPoint) tile toWorld: (CCTMXTiledMap*) world;

/** Returns true if the tile coordinate is valid in the world */
+ (bool) tile:(CGPoint) tile validIn: (CCTMXTiledMap*) world;

/** Goes to the next level */
+ (void) goLevel;

/** Goes to the game over screen */
+ (void) goOver;

/** Quits the game */
+ (void) goQuit;
@end
