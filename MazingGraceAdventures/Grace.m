//
//  Grace.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Grace.h"
#import "Helper.h"

#define STEP 4

#define FACING_LEFT 0
#define FACING_UP 1
#define FACING_RIGHT 2
#define INPUT_VERTICAL(inp) (inp == UP || inp == DOWN)

@implementation Grace
@synthesize input;

- (Grace*) initAt:(CGPoint) point of:(AbstractLevel*) level_ {
    
    [super initWithFrames: @"grace.png" width:18 andHeight:30];
    
    if(self != nil) {
        vx = vy = 0;
        
        input = STOPPED;
        
        self.position = initPosition = point;
        
        self.frameNumber = FACING_RIGHT;
        
        level = level_;
    }
    
    return self;
}

- (void) update {	
    [self updateClimbing];
    
    if(!climbing) {
        [self moveX];
	
        [self moveY];
    }
    
    input = STOPPED;
}

- (void) moveX {
    // Get current (or old) x to see if we moved
	int oldX = self.x;
    
    // Get current x velocity in case we need to roll to a tile boundary
	double vxLast = vx;
	
    // Set x velocity based on input, if any
	if(self.input == LEFT)
		vx = -VELOCITY;
    
	else if(self.input == RIGHT)
		vx = VELOCITY;
    
	else
		vx = 0;
	
    // If we're not on a tile boundary, keep moving
	if(vx == 0 && (self.x % level.tileSize != 0))
		vx = vxLast;
	
	// Move relative to current position
	[self moveToX:vx andY: 0];
	
//    CCTMXLayer* platforms = [level.world layerNamed:@"platforms"];
    CCTMXLayer* platforms = level.platforms;
    
	if(vx != 0 && [self collidesWith:platforms])
		[self moveToX:-vx andY:0];
    
	if(oldX == self.x)
		return;
    
    // Set the sprite depending on direction we're travelling
    if(vx < 0)
        self.frameNumber = FACING_LEFT;
    else if(vx > 0)
        self.frameNumber = FACING_RIGHT;
}

- (void) moveY {	
	// Check if player "jumping"
	if(vy == 0 && self.input == UP)
		vy = VELOCITY_LAUNCH;
	
	// Check if player falls from a platform
	else if(vy == 0 && ![self onPlatform])
		vy = -VELOCITY_DROP;
	
    // If not moving or no input to move, we're done here
    if(vy == 0)
        return;
    
	// If ball is in motion, update the velocity per gravity
	vy -= GRAVITY;
    
	if(vy <= -VELOCITY_TERMINAL)
		vy = -VELOCITY_TERMINAL;
    
	[self moveToX: 0 andY: vy];
    
	// If we collide with the platform layer, cancel motion
    if((vy <= 0 && [self onPlatform]) || (vy > 0 && [self hitsPlatform])) {
		[self moveToX: 0 andY: -vy];
        
		[self moveToContact];
        
		// If we collide going down, stop movement
		if(vy < 0) {
			vy = 0;
		}
        
		// If we collide going up, bounce off platform
		else {
			// "-" means reverse direction
			// "bounce factor" means platform absorbs some energy
			vy = -BOUNCE_FACTOR  * vy;
            
			// By chance velocity may be zero...which could be a problem
			if(vy == 0)
				vy = -VELOCITY_RESIDUAL;
		}
	}	
    
    return;
}

- (bool) onPlatform {
    // We're on a platform, if there's a tile immediately below
    // at grace.y-1
    CCTMXLayer* platforms = level.platforms;
	
	int xoffs[] = {0 , level.tileSize-1};
	int yoffs[] = {-1, -1};
    
	for(int i=0; i < 2; i++) {
        CGPoint tile = [Helper world:level.world toTile:ccp(self.x + xoffs[i],self.y + yoffs[i])];
        
        if(![Helper tile:tile validIn:level.world])
            continue;
        
        int gid = [platforms tileGIDAt:tile];
        
        if(gid != 0)
            return TRUE;
	}
	
	return FALSE;
}

-(bool) hitsPlatform {
    // We hit a platform if there's a tile immediately above at
    // the height of Grace -- note grace.y+h is the next tile above
    CCTMXLayer* platforms = level.platforms;
    
    CGRect frame = [self rect];
	int h = frame.size.height;

	int xoffs[] = {0  , level.tileSize-1};
	int yoffs[] = {h,   h};
    
    int x = self.x;
    int y = self.y;
    
	for(int i=0; i < 2; i++) {
//        CGPoint tile = [Helper worldToTileX:x + xoffs[i] andY:y + yoffs[i]];
        CGPoint tile = [Helper world:level.world toTile:ccp(x + xoffs[i],y + yoffs[i])];
        
        if(![Helper tile:tile validIn:level.world ])
            continue;
        
        int gid = [platforms tileGIDAt:tile];
        
        if(gid != 0)
            return TRUE;
	}
	
	return FALSE;
}

- (void) moveToContact {
	// Default creeps down
	int creep = -1;
	
	// Unless we're going up, then creep up
	if(vy > 0)
		creep = 1;
	
    CCTMXLayer* platforms = level.platforms;
	
	while([self collidesWith:platforms] == false)
		[self moveToX: 0 andY: creep];
	
    // Creep down (or up) once more to appear in contact with surface
	[self moveToX: 0 andY: -creep];
}

- (bool) collidesWithEntity:(Entity *)entity {
    CGRect me = CGRectMake(self.x, self.y, self.width,self.height);
    
    CGRect other = CGRectMake(entity.x, entity.y, entity.width, entity.height);
    
    bool collided = CGRectIntersectsRect(me, other);
    
    return collided;
}

-(bool) collidesWith:(CCTMXLayer*)layer {
    // We collide with the world if a tile is on any side
	CGRect frame = [self rect];
	int h = frame.size.height;
	
    // (Note w, h are +1 beyond the object boundary.)
	int xoffs[] = {0, 0, level.tileSize-1, level.tileSize-1};
	int yoffs[] = {0, h-1, h-1, 0};
    
    // Get grace's current position
    int x = self.x;
    int y = self.y;
    
    // Check around the four edges for collision with world
	for(int i=0; i < 4; i++) {
        CGPoint tile = [Helper world:level.world toTile:ccp(x + xoffs[i],y + yoffs[i])];
        
        if(![Helper tile:tile validIn:level.world])
            continue;        
        
        // If there is a tile at the edge, we collided
        int gid = [layer tileGIDAt:tile];
        
        if(gid != 0)
            return TRUE;
	}
	
    // We found no tile at the edge so we must not be colliding
	return FALSE;
}

- (void) updateClimbing {    
	// Climb if we're on ladda
	if(INPUT_VERTICAL(input) && [level onLadda:ccp(self.x,self.y)])
		[self climb];
	
	// Climb inertially
	else if(climbing && (self.y % level.tileSize) != 0)
		[self climb];
	
	// Get off ladda and stop climbing if player goes left or right
	else if(input == LEFT || input == RIGHT)
		climbing = FALSE;    
}

- (void) climb {
    static int step = 0;

    if(INPUT_VERTICAL(input)) {
        self.frameNumber = FACING_UP;
        
        if(input == UP)
            step = STEP;
        
        else if(input == DOWN)
            step = -STEP;
    }
    
    // Move only if we aren't on platform or don't hit a ceiling
    if((step > 0 && ![self hitsPlatform]) || (step < 0 && ![self onPlatform]))
        [self moveToX:0 andY: step];
    
	climbing = TRUE;
}

- (bool) landsOn:(Enemy*) enemy {
	// NOTE: this method assumes Grace is already colliding
	// with enemy
	
	if([self onPlatform] || self.y < enemy.y)
		return FALSE;
	
	return TRUE;
}

- (void) reset {
    self.position = initPosition;
    
    vx = vy = 0;
    
    self.frameNumber = FACING_RIGHT;
}
@end
