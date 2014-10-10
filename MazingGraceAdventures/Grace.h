//
//  Grace.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"
#import "Enemy.h"
#import "GameController.h"

#define VELOCITY 4
#define VELOCITY_TERMINAL (VELOCITY * 3)
#define VELOCITY_LAUNCH 14
#define VELOCITY_DROP 4
#define VELOCITY_RESIDUAL 0.5
#define BOUNCE_FACTOR 0.75
#define GRAVITY 0.7

/** Grace as the PC */
@interface Grace : Entity {
    enum direction input;
    double vx;
    double vy;
    CGPoint initPosition;
    bool climbing;
}

@property(nonatomic) enum direction input;

/** Constructor */
- (Grace*) initAt:(CGPoint) point of:(AbstractLevel*) level;

/** Updates Grace during the update phase */
- (void) update;

/** Moves Grace in the x direction based on input or inertially */
- (void) moveX;

/** Moves Grace in the y direction based on input or inertially */
- (void) moveY;

/** Returns true if Grace collides with an entity (enemy or goal) */
- (bool) collidesWithEntity:(Entity *)entity;

/** Returns true if Grace collides with a layer (platforms or rewards) */
- (bool) collidesWith:(CCTMXLayer*) layer;

/** Returns true if Grace standing a platform */
- (bool) onPlatform;

/** Returns true if Grace jumps and hits a platform from below */
- (bool) hitsPlatform;

/** Moves Grace to a contact point above or below */
- (void) moveToContact;

/** Returns true if Grace lands on an enemy */
- (bool) landsOn:(Enemy*) enemy;

/** Updates Grace's climbing state */
- (void) updateClimbing;

/** Grace climbs */
- (void) climb;

/** Resets Grace */
- (void) reset;
@end
