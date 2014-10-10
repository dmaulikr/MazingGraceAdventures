//
//  Credits.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Credits.h"

@implementation Credits
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Credits *layer = [Credits node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

- (id) init {
    if( (self=[super init])) {
        int screenWidth = [[CCDirector sharedDirector] winSize].width;
        int screenHeight = [[CCDirector sharedDirector] winSize].height;
        
        // create and initialize a Label
        NSString* text = @"(c) 2010-2014 by R. Coleman, sprites from GameMaker, The River War Original Mix by PANG!";
        
//        CCLabelTTF *label = [CCLabelTTF labelWithString:text dimensions: CGSizeMake(400,100) alignment:UITextAlignmentLeft  fontName:@"Marker Felt" fontSize:24];
        CCLabelTTF *label = (CCLabelTTF*)[CCLabelTTF labelWithString:text fontName:@"Marker Felt" fontSize:24 dimensions: CGSizeMake(400,100) hAlignment:NSTextAlignmentLeft];
        
        [label setColor:ccc3(198,97,255)];
        
        // position the label on the center of the screen
        label.position =  ccp( screenWidth /2 , screenHeight/2 );
        
        // add the label as a child to this Layer
        [self addChild: label];
        
        CCMenuItem *backButton =
        [CCMenuItemFont itemWithString:@"Back" target:self selector:@selector(onBack:)];
        
        CCMenu *menu = [CCMenu menuWithItems:backButton, nil];
        
        [menu alignItemsVertically];
        
        [menu setPosition:ccp(screenWidth / 2, screenHeight*0.25f)];
        
        [self addChild:menu];
    }
    
    return self;
}

-(void) onBack: (CCMenuItemFont*) button {
    [[CCDirector sharedDirector] popScene];
}
@end

