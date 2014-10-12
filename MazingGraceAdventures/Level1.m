//
//  Level1.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level1.h"
#import "Helper.h"
#import "Gorgon.h"
#import "Harpie.h"
#import "SoundEffects.h"
#import "Lives.h"

#define REWARD_CRUSH_MONSTA 20

@implementation Level1

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	Level1 *layer = [Level1 node];
	
	// add layer as a child to scene
	[scene addChild: layer z:25];
    
    [scene addChild: [GameController make] z:25];

	return scene;
}

- (id) init {
    if([self isMemberOfClass:[Level1 class]])
        world = [CCTMXTiledMap tiledMapWithTMXFile:@"level1.tmx"];
    
    if((self = [super init])) {
        bubbles = [[NSArray alloc]initWithObjects:
                   @"Caught!",@"Gotcha!",@"Take that!",@"Pow!",@"Ha, ha!",nil];
        
        feedback = [CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:24];
        
        [feedback setVisible:FALSE];
        
        [feedback setColor:ccc3(0,0,0)];
        
        [feedback setAnchorPoint:ccp(0,0)];
        
        // If you forget to add the feedback to the world and try to position
        // it later, cocos2d crashes
        [self addChild:feedback z:95];
    }

	return self;
}

- (void) initWorld {
    [super initWorld];
    
    CGSize size = [world mapSize];
    
    stalksLayer = [world layerNamed:@"stalks"];
    
    enemiesLayer = [world layerNamed:@"enemies"];
    
    [enemiesLayer setVisible:false];
    
    enemies = [[NSMutableArray alloc] init];
       
    for(int tilex = 0; tilex < size.width; tilex++) {
        for(int tiley = 0; tiley < size.height; tiley++) {
            int gid = [enemiesLayer tileGIDAt:ccp(tilex,tiley)];
            
//            CGPoint here = [Helper tileToWorldX:tilex andY:tiley];
            CGPoint here = [Helper tile:ccp(tilex,tiley) toWorld:world];
            
            if(gid == RID_GORGON) {
                Gorgon* gorgon = (Gorgon*) [[Gorgon alloc] initAt:here of:self];
                
                [self addChild:gorgon z:90];
                
                [enemies addObject:gorgon]; 
            }
            
            else if(gid == RID_HARPIE) {
                Harpie* flya = (Harpie*) [[Harpie alloc] initAt:here of:self];
                
                [self addChild:flya z:90];
                
                [enemies addObject:flya];
            }
        }
    }
}

-(void) update:(ccTime)dt {     
    if(caught || complete)
        return;
       
    [super update:dt];
    
    if(complete) {
        [Helper goLevel];
    }
        
    for(Enemy* enemy in enemies) {
        [enemy update];
    }
    
    if(caught)
        [self handlePCCaught];
}

-(void) handlePCCaught {
	[Lives decrement];
    
    [SoundEffects boo];
    
	// Select a random message
	int sz = [bubbles count];
	
	int lottery = rand() % sz;
	
	NSString* message = [bubbles objectAtIndex:lottery];
    
    [feedback setString:message];

    // Position the feedback on the screen just above grace's head.
    // (Grace's world coordinate is its screen coordinate since grace
    // has been scrolled with the world!
    //  Also, we need to take into grace's anchor which is @ (0,0). 
    feedback.position = ccp(TOPOINT(grace.x), TOPOINT(grace.y + grace.height));

    [feedback setVisible:TRUE];
	
	// Set the alarm to freeze everybody
//    [self schedule:@selector(caughtReset)];
	[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(caughtReset) userInfo:nil repeats:NO];
}

- (void) caughtReset {
	// Unfreeze everybody only if there are more lives
	if([Lives remaining] == 0) {
		[Helper goOver];
		
		return;
	}
    
//	[self unschedule:@selector(caughtReset)];
    
	// Reset grace to its initial position and not moving
    [grace reset];
    
    [feedback setVisible:FALSE];
    
	caught = FALSE;
}

- (bool) collidesWith: (id) enemy_ {
    // Check for collision with a block or platform
    Enemy* enemy = (Enemy*) enemy_;
    
    int xoffs[] = { 0, enemy.width };
    
    for(int i=0; i < 2; i++) {
        CGPoint position = ccp(enemy.x,enemy.y);
        
        position.x += xoffs[i];
        
//        CGPoint point = [Helper worldToTile: position];
        CGPoint point = [Helper world:world toTile:position];
    
        int gid = [enemiesLayer tileGIDAt:point];
    
        if(gid == RID_ENEMY_BLOCK) {
            return TRUE;
        }
    
        // Check for a collision with platforms
        gid = [platforms tileGIDAt:point];
    
        if(gid != 0) {
            return TRUE;
        }
    }
    
    // Check for a collision with Grace
    if([grace collidesWithEntity:enemy]) {
		// If grace jumps on an enemy, give 'em some points and a cheer
		if([enemy isKindOfClass:[Gorgon class]] && [grace landsOn:enemy]) {
			enemy.state = STATE_DYING;
			
			[Score increment:REWARD_CRUSH_MONSTA];
            
            [SoundEffects yeah];
			
			return FALSE;
		}
		
        // Otherwise, grace is caught       
		return caught = TRUE;        
    }
        
    return FALSE;
}

- (bool) onLadda:(CGPoint) position {
    CGPoint tile = [Helper world:world toTile:position];
    
    if(![Helper tile:tile validIn:world])
        return FALSE;
    
    int gid = [stalksLayer tileGIDAt:tile];
    
    if(gid == 0)
        return FALSE;
    
    return TRUE;    
}
@end
