//
//  GameController.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "SneakyJoystick.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Lives.h"
#import "Score.h"

/** Input directions */
enum direction {
    STOPPED = 0,
    LEFT = 1,
    RIGHT = 2,
    UP = 3,
    DOWN = 4
};

/** Game controller layer */
@interface GameController : CCLayer {
    SneakyJoystick *leftJoystick; 
    SneakyButton *quitButton;  
    CCLabelTTF *scoreLabel;
    Lives* lives;
    Score* score;
    bool ready;
}

/** Singleton gets an instance of the game controller */
+ (GameController*) instance;

/** Creates a controller */
+ (GameController*) make;

/** Updates the controller by getting player input */
- (enum direction) update;

/** Initializes the lives */
- (void) initLives;

/** Initializes the score */
- (void) initScore;

/** Initializes the joystick and button(s) */
- (void)initJoystickAndButtons;

/** Applies the joystick (invoked internally) */
- (enum direction) applyJoystick;

/* Returns true if the quit button pressed */
- (bool) quitPressed;
@end
