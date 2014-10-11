//
//  Level0.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level0.h"
#import "Helper.h"
#import "GameController.h"
#import "SimpleAudioEngine.h"
#import "SoundEffects.h"
#import "Score.h"
#import "LevelSequence.h"

#define TILED_MAP @"level0.tmx"

#define REWARD_MUSHROOM_LIL 5
#define REWARD_MUSHROOM_BIG 10

int RID_MUSHROOMS_SMALL[] = { 9, 10, 11, 12, 13, 14, 15 };
int RID_MUSHROOMS_BIG[] = { 56, 62, 63 };
int RID_PLATFORMS[] = { 1, 19, 20, 21, 25, 26, 27, 34 };
int RID_LADDAS[] = { 14, 22, 30, 38, 46, 54 };

@implementation Level0

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level0 *layer = [Level0 node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    GameController* gc = [GameController make];
    
    [scene addChild: gc z:25];
    
	// return the scene
	return scene;
}

- (id) init {
    // Load the world (we add it in initWorld)
    if([self isMemberOfClass:[Level0 class]])
        world = [CCTMXTiledMap tiledMapWithTMXFile:TILED_MAP];
    
    if( (self=[super init])) {        
        [self initWorld];

        caught = complete = FALSE;
        
        count = 0;
	}
    
    [self scheduleUpdate];
    
	return self;
}

- (void) initWorld {
    // Load the background
    CCTMXTiledMap* backg = [CCTMXTiledMap tiledMapWithTMXFile:@"backg.tmx"];
    
    [self addChild: backg z:0];

    [self addChild: world z:50];
    
//    [Helper setWorld:world];
    
    tileSize = [world tileSize].width;
    
    rewardsLayer = [world layerNamed:@"rewards"];

    platforms = [world layerNamed:@"platforms"];
    
    CGSize map = [world mapSize];
    
    for(int tilex = 0; tilex < map.width; tilex++) {
        for(int tiley = 0; tiley < map.height; tiley++) {
            int gid = [platforms tileGIDAt:ccp(tilex,tiley)];
            
//            CGPoint here = [Helper tileToWorldX:tilex andY:tiley];
            CGPoint here = [Helper tile:ccp(tilex,tiley) toWorld:world];
            
            if(gid == RID_GRACE) {               
                grace = [[Grace alloc] initAt:here of:self];
                
                [self addChild: grace z: 90];
                
                [platforms removeTileAt:ccp(tilex,tiley)];
            }
            
            else if(gid == RID_GOAL) {
                goal = (Goal*) [[Goal alloc] initAt:here];
                               
                [self addChild: goal z:90];
                
                [platforms removeTileAt:ccp(tilex,tiley)];
            }
        }
    }
    return;
}

-(void) update:(ccTime)dt {  
    if([[GameController instance] quitPressed])
        [Helper goQuit];
        
    grace.input = [[GameController instance] update];
    
    if(complete)
        return;
    
    if(grace.input != STOPPED)
        count++;
    
    [grace update];
    
    if([grace collidesWith: rewardsLayer]) {
        [self handlePCRewardCollision];
    }
	else if([grace collidesWithEntity:goal]) {
        [self handlePCGoalCollision];
	}

    [self scroll];
}

- (void) handlePCRewardCollision {
//	CGPoint gracePos = [grace position];
	
	int x = grace.x;
	int y = grace.y;
    
//    CGPoint contact = [Helper worldToTileX:x andY:y];
    CGPoint contact = [Helper world:world toTile:ccp(x,y)];
	
	int gid = [rewardsLayer tileGIDAt:contact];
	
	if(gid == 0) {
		x += world.tileSize.width;
		
//		contact = [Helper worldToTileX:x andY:y];
        contact = [Helper world:world toTile:ccp(x,y)];
		
		gid = [rewardsLayer tileGIDAt:contact];
	}
	
	if([self isLilMushroom:gid]) {
		mushRoomCount--;
        
        [Score increment:REWARD_MUSHROOM_LIL];
		
        [SoundEffects lil];
	}
	else if([self isBigMushroom:gid]) {
		mushRoomCount--;

        [Score increment:REWARD_MUSHROOM_BIG];
		
        [SoundEffects big];
	}
	
	[rewardsLayer removeTileAt:contact];
}

- (void) handlePCGoalCollision {   
    complete = TRUE;
    
    if([self isMemberOfClass:[Level0 class]])
        [Helper goLevel];
    
    [self unschedule:@selector(update:)];
}

- (void) scroll {
    [self scrollX];
    
    [self scrollY];
}

- (void) scrollX {
    // Scrolling in X direction is relatively simple since grace stops on a tile boundary
    
    // Get grace's x which Entity ensures is a pixel (ie, world) coordinate
    float graceX = grace.x;

    // Seems with Retina display, the screen width is stored in points but we need pixels.
    int screenWidth = TOPIXEL([[CCDirector sharedDirector] winSize].width);
    
    // Get the half screen width to know when we need to scroll left or right
    float halfOfTheScreen = screenWidth / 2.0f;
    
    // Get the level height to know when we need to scroll up or down
    int levelWidth = world.mapSize.width * world.tileSize.width;
    
    // Scroll the background if we're not at the edge of the world
    if ((graceX >= halfOfTheScreen) && (graceX < (levelWidth - halfOfTheScreen))) {
        float newXPosition = (halfOfTheScreen - graceX);
        
        [self setPosition:ccp(newXPosition,TOPIXEL(self.position.y))];
    }
    
    return;
}

- (void) scrollY {   
    // Scrolling Y direction is more complicated since grace may be travelling
    // under continuous gravity rather than to/from tile boundaries.
    
    // Get the screen Y which is store by cocos2d as a point. For sprites
    // the Entity class handles this converversion. For layers, we must
    // deal with this manually for any position or size coming from the layer.
    int screenY = TOPIXEL(self.position.y);
    
    // Get the grace's y which again Entity converts to pixel (ie, world) coordinate for us
    int graceY = grace.y;
    
    // Get the screen height which is whatever the orientation is, ie, 3.5" portrait mode
    // is 640 that whereas in landscape mode is 960 or something like that.
    int screenHeight = TOPIXEL([[CCDirector sharedDirector] winSize].height);
    
    // Get the tile height which is pretty much a constant.
    int tileHeight = world.tileSize.height;
    
    // Get the half screen height to know when we need to scroll up or down
    float halfScreenHeight = screenHeight / 2.0f;
    
    // Get the level height to know when we need to scroll up or down
    int levelHeight = world.mapSize.width * world.tileSize.height;
    
    // Scroll the background if we're not at the edge of the world
    if ((graceY >= halfScreenHeight) && (graceY < (levelHeight - halfScreenHeight))) {
        float newYPosition = halfScreenHeight - graceY;
        
        [self setPosition:ccp(TOPIXEL(self.position.x),newYPosition)];
    }
    
    // Screen may not settle on tile boundary and we need to force it there.
    else if((screenY % tileHeight) != 0) {
        // Discrepancy is amount to move the screen
        int d = screenY % tileHeight;
        
        // Move the screen in the opposite direction of the discrepancy
        screenY += -d;
        
        [self setPosition: ccp(TOPIXEL(self.position.x),screenY)];
    }
}

- (void) setPosition:(CGPoint)position {
    [super setPosition:CGPointMake(TOPOINT(position.x), TOPOINT(position.y))];
}

- (bool) isMushroom: (int) gid {
	return [self isLilMushroom:gid] || [self isBigMushroom:gid];
}

- (bool) isLilMushroom:(int) gid {
	int sz = sizeof(RID_MUSHROOMS_SMALL)/sizeof(int);
	
	for(int i=0; i < sz; i++)
		if(gid == RID_MUSHROOMS_SMALL[i])
			return true;
	
	return false;
}

- (bool) isBigMushroom:(int) gid {
	int sz = sizeof(RID_MUSHROOMS_BIG)/sizeof(int);
	
	for(int i=0; i < sz; i++)
		if(gid == RID_MUSHROOMS_BIG[i])
			return true;
	
	return false;
}

- (bool) isLadda:(int) gid {
	int sz = sizeof(RID_LADDAS)/sizeof(int);
	
	for(int i=0; i < sz; i++) {
		if(gid == RID_LADDAS[i])
			return true;
	}
	
	return false;
}


- (bool) isPlatform:(int) gid {
	int sz = sizeof(RID_PLATFORMS)/sizeof(int);
	
	for(int i=0; i < sz; i++)
		if(gid == RID_PLATFORMS[i])
			return true;
	
	return false;
}
@end
