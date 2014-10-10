//
//  InterLevel.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InterLevel.h"
#import "LevelSequence.h"
#import "AbstractLevel.h"

static bool quit = FALSE;

@implementation InterLevel
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InterLevel *layer = [InterLevel node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init {
    if( (self=[super init])) { 
        int screenWidth = [[CCDirector sharedDirector] winSize].width;
        int screenHeight = [[CCDirector sharedDirector] winSize].height;
        
        NSString* title = @"Level ";
        
        title = [title stringByAppendingString:[NSString stringWithFormat:@"%d",[LevelSequence levelNumber]]];
                
        CCLabelTTF *label = [CCLabelTTF labelWithString:title fontName:@"Marker Felt" fontSize:64];
        
		// position the label on the center of the screen
		label.position =  ccp( screenWidth /2 , screenHeight/2 );
        
        [label setColor:ccc3(198,97,255)];
        
        [self addChild:label];
        
        CCMenuItem *quitButton =
            [CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(onQuit:)];
        
        CCMenu *menu = [CCMenu menuWithItems:quitButton, nil];
        
        [menu alignItemsVertically];
        
        [menu setPosition:ccp(screenWidth / 2, screenHeight*0.25f)];
        
        [self addChild:menu];
        
        [self schedule:@selector(timeout) interval:0.50f];
    }
    
    return self;
}

- (void) timeout {
    [self unschedule:@selector(timeout)];
    
    if(quit)
        return;
    
    Class level = [LevelSequence nextLevel];
	
	if(level == nil)
		[self onQuit:nil];
	else {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionRotoZoom transitionWithDuration:2.0 scene:[level scene]]]; 
    }
    
    return;
}

-(void) onQuit: (CCMenuItemFont*) button {
    [self unschedule:@selector(timeout)];
    
    quit = TRUE;
    
    [[CCDirector sharedDirector] popScene];
}
@end
