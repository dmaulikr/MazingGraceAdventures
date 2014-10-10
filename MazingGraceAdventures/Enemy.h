//
//  Enemy.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"

/** States of an enemy */
enum state {
    STATE_ALIVE=2,
    STATE_DYING=1,
    STATE_DEAD=0
};

/** Base class for enemies */
@interface Enemy : Entity {
    int xSpeed;
    int ySpeed;
    enum state state;
}

@property(nonatomic) enum state state;

/** Updates an enemy */
-(void) update;

/** Moves enemy relative to current location */
-(void) moveTo: (int) x and: (int)y;

/** Moves conditionally */
-(void) moveOnCondition;

/** Returns true if enemy collides with the level */
-(bool) collidesWithLevel;

/** handles a collision event */
-(void) collisionEvent;

@end
