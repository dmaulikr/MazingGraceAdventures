//
//  Complete.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Complete.h"

@implementation Complete
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Complete *layer = [Complete node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init {
    if( (self=[super init])) { 
        int screenWidth = [[CCDirector sharedDirector] winSize].width;
        int screenHeight = [[CCDirector sharedDirector] winSize].height;
        
        NSString* title = @"You Won !";
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:title fontName:@"Marker Felt" fontSize:64];
        
		// position the label on the center of the screen
		label.position =  ccp( screenWidth /2 , screenHeight/2 );
        
        label.color = ccc3(0,255,0);
        
        [self addChild:label];
        
        CCMenuItem *continueButton =
        [CCMenuItemFont itemWithString:@"Continue" target:self selector:@selector(onContinue:)];
        
        CCMenu *menu = [CCMenu menuWithItems:continueButton, nil];
        
        [menu alignItemsVertically];
        
        [menu setPosition:ccp(screenWidth / 2, screenHeight*0.25f)];
        
        [self addChild:menu];
    }
    
    return self;
}

- (void) onContinue: (CCMenuItemFont*) button {   
    [[CCDirector sharedDirector] popScene];
}
@end
