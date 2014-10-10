//
//  Coordinate.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Helper.h"
#import "Complete.h"
#import "GameOver.h"
#import "InterLevel.h"
#import "LevelSequence.h"
#import "SoundEffects.h"

@implementation Helper

+ (void) goLevel {   
    if([LevelSequence numberOfLevels] != [LevelSequence levelNumber]) {
        [SoundEffects done];
        
//        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[InterLevel scene]]];
        [[CCDirector sharedDirector] replaceScene:[InterLevel scene]];
    }
    else {	
        [SoundEffects cheer];
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[Complete scene]]];
    }
}

+ (void) goOver {
    [SoundEffects disappoint];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2.0 scene:[GameOver scene]]];
}

+ (void) goQuit {
    [[CCDirector sharedDirector] popScene];
}

+ (bool) tile:(CGPoint) tile validIn: (CCTMXTiledMap*) world {
    // Tile coordinates are valid if they are in the world
    CGSize mapSize = [world mapSize];
    
    bool outsideWorld = 
        tile.x < 0 || 
        tile.y < 0 || 
        tile.x >= mapSize.width || 
        tile.y >= mapSize.height;
    
    return !outsideWorld;
}

+ (CGPoint) world: (CCTMXTiledMap*) world toTile: (CGPoint) point {
    CGSize tileSize = world.tileSize;
    
    int tilex = (point.x / tileSize.width);
    
    int tiley = (world.mapSize.height - (int) (point.y / tileSize.height) - 1);
    
    return ccp(tilex, tiley);    
}

+ (CGPoint) tile: (CGPoint) tile toWorld: (CCTMXTiledMap*) world  {
    CGSize tileSize = world.tileSize;
    
    int worldx = tile.x * tileSize.height;
    
    int worldy = (world.mapSize.height - tile.y - 1) * tileSize.height;
    
    return ccp(worldx, worldy);    
}
@end
