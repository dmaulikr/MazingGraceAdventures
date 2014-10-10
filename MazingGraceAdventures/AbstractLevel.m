//
//  AbstractLevel.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbstractLevel.h"

@implementation AbstractLevel
@synthesize tileSize;
@synthesize platforms;
@synthesize world;

- (bool) collidesWith: (id) enemy {
    return FALSE;
}
- (bool) onLadda:(CGPoint) position {
    return FALSE;
}

- (void) update:(ccTime)dt {
    
}
@end
