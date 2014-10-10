//
//  GameController.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
#import "LevelSequence.h"
#import "InterLevel.h"
#import "Complete.h"
#import "GameOver.h"

#define HT_FRACTION 0.95

static GameController* gameController = nil;

@implementation GameController
+ (GameController*) instance {
    return gameController;
}

+ (GameController*) make {
    gameController = [[GameController alloc] init];
    
    return gameController;
}

- (GameController*) init {
    if( (self=[super init])) {
        [self initJoystickAndButtons];
        
        [self initLives];
        
        [self initScore];
        
        ready = TRUE;
    }
    
    return self;
}

- (enum direction) update {
    [lives update];
    
    [score update];
    
    return [self applyJoystick];
}

- (bool) quitPressed {
    return quitButton.active;
}


- (enum direction) applyJoystick;
{
    enum direction dir = STOPPED;
    
    // Get the continuous input scaled
    CGPoint velocity = ccpMult(leftJoystick.velocity, 128.0f); 
    
    // Transform continuous velocity input to tri-state output 
    int avx = abs(velocity.x);
    int avy = abs(velocity.y);
    
    if(avx > avy && ready) {
        if(velocity.x > 0)
            dir = RIGHT;
        else
            dir = LEFT;
    }
    else if(avx < avy && ready) {
        if(velocity.y > 0)
            dir = UP;
        else
            dir = DOWN;
    }
    
    // Since the joystick may take a couple of cycles to
    // reset, we need to wait until it goes back to zero
    // i.e., it is "ready", before reporting more output.
    bool gotInput = avx != 0 || avy != 0;
    
    if(ready && gotInput) {
        ready = FALSE;
    }
    
    else if(!ready && !gotInput) {
        ready = TRUE;
    }
    
    return dir;
}

- (void) initLives {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    lives = [[Lives alloc] initAt: ccp(screenSize.width*0.10 , screenSize.height*HT_FRACTION)];
    
    [self addChild:lives];    
}

- (void) initScore {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    score = [[Score alloc] initAt: ccp(screenSize.width*0.55 , screenSize.height*HT_FRACTION)];
    
    [self addChild:score];    
}

-(void)initJoystickAndButtons {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    CGRect joystickBaseDimensions = CGRectMake(0, 0, 128.0f, 128.0f);
    CGRect quitButtonDimensions = CGRectMake(0, 0, 32.0f, 32.0f);
    
    CGPoint joystickBasePosition;
    CGPoint quitButtonPosition;
    
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        // The device is an iPad running iPhone 3.2 or later.
    //        CCLOG(@"Positioning Joystick and Buttons for iPad");
    //        joystickBasePosition = ccp(screenSize.width*0.0625f,
    //                                   screenSize.height*0.052f);
    //        
    //        quitButtonPosition = ccp(screenSize.width*0.946f,
    //                                 screenSize.height*0.80f);
    //        
    //    }
    //    else {
    // The device is an iPhone or iPod touch.       
    joystickBasePosition = ccp(screenSize.width*0.07f, screenSize.height*0.11f);
    
    quitButtonPosition = ccp(screenSize.width-16.0f, screenSize.height-16.0f);
    //    }
    
    SneakyJoystickSkinnedBase *joystickBase = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    joystickBase.position = joystickBasePosition;
    
    joystickBase.backgroundSprite = [CCSprite spriteWithFile:@"dpadDown3.png"];
    
    joystickBase.thumbSprite = [CCSprite spriteWithFile:@"joystickDown.png"];
    
    joystickBase.joystick = [[SneakyJoystick alloc] initWithRect:joystickBaseDimensions];
    
    leftJoystick = [joystickBase.joystick retain];
    
    [self addChild:joystickBase];
    
    SneakyButtonSkinnedBase *quitButtonBase = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    quitButtonBase.position = quitButtonPosition;
    
    quitButtonBase.defaultSprite = [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.activatedSprite = 
    [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.pressSprite = 
    [CCSprite spriteWithFile:@"quit-button2.png"];
    
    quitButtonBase.button = [[SneakyButton alloc]initWithRect:quitButtonDimensions];
    
    quitButton = [quitButtonBase.button retain];
    
    quitButton.isToggleable = NO;
    
    [self addChild:quitButtonBase]; 
}
@end
