//
//  Lives.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Lives.h"
#import "Entity.h"
#import "Helper.h"


#define NUM_LIVES 3
#define SCALE 2
#define BLOCK_SIZE TOPOINT(16)
#define GAP 2

// Offsets into the tile set of the lives tile
#define LIFE_X TOPOINT(48)
#define LIFE_Y TOPOINT(48)
#define LIFE_W TOPOINT(16)
#define LIFE_H TOPOINT(16)

static int value = NUM_LIVES;
static CCLayer* lives = nil;

@implementation Lives
- (id) initAt:(CGPoint) point {
    if((self = [super init])) {        
        lives = self;
        
        // Get the lives tile
        CCTexture2D* texture =
            [[CCTextureCache sharedTextureCache] addImage:@"tiles_mga.png"];
        
        CCSpriteFrame *life =
            [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(LIFE_X, LIFE_Y, LIFE_W, LIFE_H)];
        
        // Add the lives as sprites to the layer
        for(int i=0; i < [Lives remaining]; i++) {
            CCSprite* sprite = [CCSprite node];
            
            [sprite setDisplayFrame:life];
            
            // Position the life with a gap appropriate for the scale
            sprite.position = ccp(point.x + (BLOCK_SIZE*SCALE + GAP) * i, point.y);
            
            sprite.scale = SCALE;
            
            // Tag the life which we'll retrieve by id number
            [self addChild:sprite z:100 tag: i];
        }
    }
    
    return self;
}

+ (int) remaining {
	return value;
}

+ (void) increment {
	++value;
}

+ (void) decrement {
    --value;
    
    if(value >= 0) {
        CCSprite* life = (CCSprite*) [lives getChildByTag:value];
        
        [life setVisible:FALSE];
    }
}

- (void) update {
    
}
@end
