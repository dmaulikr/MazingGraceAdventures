//
//  Entity.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AbstractLevel.h"

/** Base class for all entities */
@interface Entity : CCSprite {
    CCTexture2D *texture;
    AbstractLevel* level;
}

@property(nonatomic) int width;
@property(nonatomic) int height;
@property(nonatomic) int frameNumber;
@property(nonatomic,readonly) int frameCount;
@property(nonatomic) int x;
@property(nonatomic) int y;

/** Constructor */
- (Entity*) initWithFrames: (NSString*) fileName width: (int) width andHeight:(int) height;

/** Updates the entity -- MUST OVERRIDE THIS METHOD !!! */
- (void) update;

/** Moves entity relative to current location. */
- (void) moveToX:(double)x andY:(double)y;

//- (CGPoint) position;

/** Sets x, y position in world */
- (void) setPosition:(CGPoint)position;

/** Gettor for x coordinate of entity position or use dot x */
- (int) x;

/** Settor for x coordinate of entity position or use dot x */
- (void) setX: (int) x;

/** Gettor for y coordinate of entity position or use dot y */
- (int) y;

/** Settor for y coordinate of entity position or use dot y */
- (void) setY: (int) y;

/** Settor for the entity frame or just use dot frameNumber */
- (void) setFrameNumber: (int) value;

/** Goes to next frame */
- (void) nextFrame;

/** Goes to previous frame */
- (void) prevFrame;

/** Gets the frame's rectangle */
- (CGRect) rect;

/** Tosses a coin */
- (int) toss;

@end
