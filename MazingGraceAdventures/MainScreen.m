//
//  MainScreen.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 1/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "InterLevel.h"
#import "Credits.h"
#import "SimpleAudioEngine.h"
#import "Options.h"


@implementation MainScreen
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene* scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScreen *layer = [MainScreen node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init {
    if( (self=[super init])) {       
        screenWidth = [[CCDirector sharedDirector] winSize].width;
        
        screenHeight = [[CCDirector sharedDirector] winSize].height;

        [self initTitle];
        
        [self initMenu];
        
        [self initLogo];
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void) initTitle {
    NSString* text = @"Mazing Grace Adventures"; 
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:text fontName:@"Marker Felt" fontSize:44];
    
    [label setColor:ccc3(198,97,255)];
    
    label.position = ccp(screenWidth/2,screenHeight*0.65);
    
    [self addChild:label];    
}

- (void) initMenu {
    CCMenuItem *startButton =
        [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(onStart:)];
    
    CCMenuItem *soundOnItem =
        [CCMenuItemImage itemWithNormalImage:@"soundon.png"
                               selectedImage:@"soundon.png"
                                      target:nil
                                    selector:nil];
    
    CCMenuItem *soundOffItem =
        [CCMenuItemImage itemWithNormalImage:@"soundoff.png"
                               selectedImage:@"soundoff.png"
                                      target:nil
                                    selector:nil];
    soundOnItem.scale = 1.5;
    soundOffItem.scale = 1.5;
    
    CCMenuItemToggle *soundToggleItem =
        [CCMenuItemToggle itemWithTarget:self selector:@selector(onToggleSound:) items:soundOnItem, soundOffItem, nil];
    
    bool soundsOn = [Options soundsOn];
    
    soundToggleItem.selectedIndex =  soundsOn ? 0 : 1;
    
    if(soundsOn)
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Mindblogger.mp3" loop:true];
    
    CCMenuItem *quitButton =
        [CCMenuItemFont itemWithString:@"Quit" target:self selector:@selector(onQuit:)];
    
    CCMenuItem *creditsButton =
        [CCMenuItemFont itemWithString:@"Credits" target:self selector:@selector(onCredits:)];
    
    CCMenu *menu = [CCMenu menuWithItems:startButton, quitButton, creditsButton, soundToggleItem, nil];
    
    [menu alignItemsVertically];
    
    [menu setPosition:ccp(screenWidth / 2, screenHeight*0.30f)];
    
    [self addChild:menu];
}

- (void) initLogo {
    CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:@"grace.png"];
    
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(18*2, 0, 18, 30)];
    
    CCSprite* logo = [CCSprite node];
    
    [logo setDisplayFrame: frame];
    
    logo.position = ccp(screenWidth * 0.34, screenHeight* 0.75);
    
    logo.scale = 1.5;
    
    [self addChild:logo];
}


-(void) update:(ccTime)dt {

}

-(void) onStart: (CCMenuItemFont*) button {    
    [[CCDirector sharedDirector] pushScene:[InterLevel scene]];
}

- (void) onToggleSound: (CCMenuItem*) button {    
    if([Options soundsOn]) {
        [Options enableSounds:FALSE];
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    }
    else {
        [Options enableSounds:TRUE];
        
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Mindblogger.mp3" loop:true];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"4225775_The_River_War_Original_Mix.mp3" loop:true];
    }
}

-(void) onQuit: (CCMenuItemFont*) button {
    exit(0);
}

-(void) onCredits: (CCMenuItemFont*) button {
    [[CCDirector sharedDirector] pushScene:[Credits scene]];
}

@end
