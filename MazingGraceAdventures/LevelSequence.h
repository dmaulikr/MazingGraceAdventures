//
//  LevelSequence.h
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Convenience class to select the next level */
@interface LevelSequence : NSObject

/** Gets the current level number */
+ (int) levelNumber;

/** Gets the next level */
+ (Class) nextLevel;

/** Gets the number of levels */
+ (int) numberOfLevels;
@end
