//
//  Entity.m
//  iMGABaseCC
//
//  Created by Ron Coleman on 12/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entity.h"
#import "Helper.h"

@implementation Entity
@synthesize frameCount;
@synthesize frameNumber;
@synthesize width;
@synthesize height;
@synthesize x = x_;
@synthesize y = y_;

-(Entity*) initWithFrames: (NSString*) fileName width: (int) width_ andHeight:(int) height_ {
    self = [super init];
    
    if(self != nil) {
        [self setAnchorPoint:ccp(0,0)];
        
        width = width_;
        
        height = height_;
        
        texture = [[CCTextureCache sharedTextureCache] addImage:fileName];
        
        CGSize size = texture.contentSizeInPixels;
        
        frameCount = size.width / width;
        
        self.frameNumber = 0;
    }
    
    return self;
}

// Overrides the synthesized settor which sets the number and the frame
// if self.frameNumber is on lhs.
-(void) setFrameNumber:(int)value {
    // Set the frame number to remember if we're asked by gettor
    frameNumber = value % self.frameCount;
    
    // Get the frame
    CGRect rect = CGRectMake(frameNumber * TOPOINT(width), 0, TOPOINT(width), TOPOINT(height));
    
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:rect];
    
    // Set this frame for display
    [self setDisplayFrame:frame];
}

// Override this method
- (void) update {
    
}

- (void) moveToX:(double)offsetX andY:(double)offsetY {
    [self setPosition:ccp((self.x+offsetX), (self.y+offsetY))];
}

-(void) nextFrame {
    self.frameNumber = (self.frameNumber + 1) % self.frameCount;
}

-(void) prevFrame {
    int frameno = self.frameNumber - 1;
    
    if(frameno < 0)
        frameno = self.frameCount - 1;
    
    self.frameNumber = frameno;
}

//- (CGPoint) position {
//    CGPoint pt = [super position];
//    
//    return ccp(TOPIXEL(pt.x),TOPIXEL(pt.y));
//}

-(void) setPosition:(CGPoint)position {
    x_ = position.x;
    y_ = position.y;
    [super setPosition:ccp(TOPOINT(position.x),TOPOINT(position.y))];
}

- (int) xPos {
    return TOPIXEL([self position].x);
}

- (int) yPos {
    return TOPIXEL([self position].y);
}

- (int)x {
    x_ = TOPIXEL([self position].x);
    
    return x_;
}

- (int)y {
    y_ = TOPIXEL([self position].y);
    
    return y_;
}

- (void) setX: (int) value {
    [self setPosition:ccp(value,y_)];
}

- (void) setY: (int) value {
    [self setPosition:ccp(x_,value)];
}

- (CGRect) rect {
    CGRect frame = [[self displayFrame] rect];
    
    frame.size.width *= PIXELS_PER_POINT;
    frame.size.height *= PIXELS_PER_POINT;
    
    frame.origin = ccp(x_,y_);
    
    return frame;
}


- (int) toss {
    int flip = rand() % 2;
    
    return flip == 1 ? 1 : -1;
}
@end
