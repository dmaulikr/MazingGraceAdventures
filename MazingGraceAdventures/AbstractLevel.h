//
//  AbstractLevel.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

/** Base class for levels */
@interface AbstractLevel : CCLayer {
    CCTMXTiledMap* world;
    CCTMXLayer* platforms;
    int tileSize;
}

@property(nonatomic,assign) int tileSize;
@property(nonatomic,assign) CCTMXLayer* platforms;
@property(nonatomic,readonly) CCTMXTiledMap* world;

/** Updates the level */
- (void) update:(ccTime)dt;

/** Returns true if enemy collides with the level */
- (bool) collidesWith: (id) enemy;

/** Returns true if the position is on the ladda */
- (bool) onLadda:(CGPoint) position;

@end
