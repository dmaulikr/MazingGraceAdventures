//
//  Harpie.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Harpie.h"

#define SPEED_FLYA 4

#define FACING_LEFT 1
#define FACING_RIGHT 0

@implementation Harpie
- (id) initAt:(CGPoint) here of:(AbstractLevel*) level_ {
    [super initWithFrames: @"harpie.png" width:32 andHeight:32];
    
	state = STATE_ALIVE;
	
	xSpeed = SPEED_FLYA * [self toss];
	
	ySpeed = 0;
    
    [self collisionEvent];
	
	[self setPosition:here];
    
    level = level_;
	
	return self;
}

-(void) collisionEvent {
	if(state != STATE_ALIVE)
		return;
    
	xSpeed *= -1;
	
	if(xSpeed > 0)
		self.frameNumber = FACING_RIGHT;
	else 
		self.frameNumber = FACING_LEFT;
}
@end
