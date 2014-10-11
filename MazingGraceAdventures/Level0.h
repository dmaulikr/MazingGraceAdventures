//
//  Level0.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbstractLevel.h"
#import "Grace.h"
#import "Goal.h"

#define RID_NO_TILE 0
#define RID_WALL 1
#define RID_GRACE 2
#define RID_GORGON 45
#define RID_HARPIE 53
#define RID_GOAL 60
#define RID_ENEMY_BLOCK 61
#define RID_MUSHROOM_SMALL 9
#define RID_MUSHROOM_BIG 56
#define RID_GROUND 34
#define RID_BLOCK_PLATFORM 57

/** Level 0 handles the goal, rewards and scrolling */
@interface Level0 : AbstractLevel {
    int count;
    bool caught;
	bool complete;
	int mushRoomCount;
    NSMutableArray* rungs;
	Goal* goal;
	Grace* grace;
    CCTMXLayer* rewardsLayer;
    CCTMXLayer* stalksLayer;
}

/** Gets a scene for this layer */
+ (CCScene *) scene;

/** Constructor */
- (id) init;

/** Initializes the world */
- (void) initWorld;

/** Updates the level */
- (void) update:(ccTime)dt;

/** Scrolls in x and y directions */
- (void) scroll;

/** Scrolls in the x direction only */
- (void) scrollX;

/** Scrolls in the y direction only */
- (void) scrollY;

/** Overrides CCLayer method so as to handle retina displays. */
- (void) setPosition:(CGPoint)position;

/** Handles PC-rewards collisions */
- (void) handlePCRewardCollision;

/** Handles PC-goal collisions */
- (void) handlePCGoalCollision;

/** Returns true if the GID is a mushroom */
- (bool) isMushroom:(int) gid;

/** Returns true if the GID is a lil mushroom */
- (bool) isLilMushroom:(int) gid;

/** Returns true if the GID is a big mushroom */
- (bool) isBigMushroom:(int) gid;

/** Returns true if the GID is a ladda type */
- (bool) isLadda:(int) gid;

/** Returns true if the GID is a platform type */
- (bool) isPlatform:(int) gid;
@end
