//
//  Enemy.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy
@synthesize state;

-(void) update {
	if(state != STATE_ALIVE)
		return;
	
	[self moveOnCondition];
}

-(void) moveTo:(int) x and: (int) y {
	[self setPosition:ccp(self.position.x + x,self.position.y + y)];
}

-(void) moveOnCondition {
	[self moveTo: xSpeed and: ySpeed];
	
	if([self collidesWithLevel]) { 
		[self moveTo: -xSpeed and: -ySpeed];
		
		[self collisionEvent];
	}
}

-(bool) collidesWithLevel {
	return [level collidesWith: self];
}

-(void) collisionEvent {
}
@end
