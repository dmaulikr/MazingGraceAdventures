//
//  Level1.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level0.h"

/** Level 1 handles enemies */
@interface Level1 : Level0 {
	NSMutableArray* enemies;
    CCTMXLayer* enemiesLayer;
    NSArray* bubbles;
    CCLabelTTF* feedback;
}

/** Gets a scene for this layer */
+ (CCScene *) scene;

/** Constructor */
- (id) init;

/** Initializes the world */
- (void) initWorld;

/** Updates the level */
- (void) update:(ccTime)dt;

/** Handles PC caught by enemy */
- (void) handlePCCaught;

/** Handles resetting everything if PC caught */
- (void) caughtReset;
@end
