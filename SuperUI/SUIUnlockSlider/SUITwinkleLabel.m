//
//  SUITwinkleLabel.m
//  Pomodoro
//
//  Created by OpenThread on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SUITwinkleLabel.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat gradientWidth = 0.2;
static const CGFloat gradientDimAlpha = 0.5;
static const int animationFramesPerSec = 8;

@interface LabelDelegate : NSObject
{
    __unsafe_unretained SUITwinkleLabel *_twinkleLabel;
}

@property (nonatomic,assign) SUITwinkleLabel *twinkleLabel;

@end

@implementation LabelDelegate

@synthesize twinkleLabel = _twinkleLabel;

- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext
{
	// Set the font
	const char *labelFontName = [_twinkleLabel.font.fontName UTF8String];
	
	// Note: due to use of kCGEncodingMacRoman, this code only works with Roman alphabets! 
	// In order to support non-Roman alphabets, you need to add code generate glyphs,
	// and use CGContextShowGlyphsAtPoint
	CGContextSelectFont(theContext, labelFontName, _twinkleLabel.font.pointSize, kCGEncodingMacRoman);
    
	// Set Text Matrix
	CGAffineTransform xform = CGAffineTransformMake(1.0,  0.0,
													0.0, -1.0,
													0.0,  0.0);
	CGContextSetTextMatrix(theContext, xform);
	
	// Set Drawing Mode to clipping path, to clip the gradient created below
	CGContextSetTextDrawingMode (theContext, kCGTextClip);
	
	// Draw the label's text
	const char *text = [_twinkleLabel.text cStringUsingEncoding:NSMacOSRomanStringEncoding];
	CGContextShowTextAtPoint(
                             theContext, 
                             0, 
                             (size_t)_twinkleLabel.font.ascender,
                             text, 
                             strlen(text));
    
	// Calculate text width
	CGPoint textEnd = CGContextGetTextPosition(theContext);
	
	// Get the foreground text color from the UILabel.
	// Note: UIColor color space may be either monochrome or RGB.
	// If monochrome, there are 2 components, including alpha.
	// If RGB, there are 4 components, including alpha.
	CGColorRef textColor = _twinkleLabel.textColor.CGColor;
	const CGFloat *components = CGColorGetComponents(textColor);
	size_t numberOfComponents = CGColorGetNumberOfComponents(textColor);
	BOOL isRGB = (numberOfComponents == 4);
	CGFloat red = components[0];
	CGFloat green = isRGB ? components[1] : components[0];
	CGFloat blue = isRGB ? components[2] : components[0];
	CGFloat alpha = isRGB ? components[3] : components[1];
    
	// The gradient has 4 sections, whose relative positions are defined by
	// the "gradientLocations" array:
	// 1) from 0.0 to gradientLocations[0] (dim)
	// 2) from gradientLocations[0] to gradientLocations[1] (increasing brightness)
	// 3) from gradientLocations[1] to gradientLocations[2] (decreasing brightness)
	// 4) from gradientLocations[3] to 1.0 (dim)
	size_t num_locations = 3;
	
	// The gradientComponents array is a 4 x 3 matrix. Each row of the matrix
	// defines the R, G, B, and alpha values to be used by the corresponding
	// element of the gradientLocations array
	CGFloat gradientComponents[12];
	for (int row = 0; row < num_locations; row++) {
		int index = 4 * row;
		gradientComponents[index++] = red;
		gradientComponents[index++] = green;
		gradientComponents[index++] = blue;
		gradientComponents[index] = alpha * gradientDimAlpha;
	}
    
	// If animating, set the center of the gradient to be bright (maximum alpha)
	// Otherwise it stays dim (as set above) leaving the text at uniform
	// dim brightness
	if (_twinkleLabel.animationTimer) {
		gradientComponents[7] = alpha;
	}
    
	// Load RGB Colorspace
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	
	// Create Gradient
	CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents,
																  _twinkleLabel.gradientLocations, num_locations);
	// Draw the gradient (using label text as the clipping path)
	CGContextDrawLinearGradient (theContext, gradient, _twinkleLabel.bounds.origin, textEnd, 0);
	
	// Cleanup
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorspace);
}

@end

@implementation SUITwinkleLabel

@synthesize animationTimer = _animationTimer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _labelDelegate = [[LabelDelegate alloc] init];
        _labelDelegate.twinkleLabel = self;
        self.layer.delegate = _labelDelegate;
        self.text = @"";
    }
    return self;
}

- (CGFloat *)gradientLocations
{
    return _gradientLocations;
}


- (void) setGradientLocations:(CGFloat) leftEdge {
	// Subtract the gradient width to start the animation with the brightest 
	// part (center) of the gradient at left edge of the label text
	leftEdge -= gradientWidth;
	
	//position the bright segment of the gradient, keeping all segments within the range 0..1
	_gradientLocations[0] = leftEdge < 0.0 ? 0.0 : (leftEdge > 1.0 ? 1.0 : leftEdge);
	_gradientLocations[1] = MIN(leftEdge + gradientWidth, 1.0);
	_gradientLocations[2] = MIN(_gradientLocations[1] + gradientWidth, 1.0);
	
	// Re-render the label text
	[self.layer setNeedsDisplay];
}

// animationTimer methods
- (void)animationTimerFired:(NSTimer*)theTimer {
    // Let the timer run for 2 * FPS rate before resetting.
    // This gives one second of sliding the highlight off to the right, plus one
    // additional second of uniform dimness
    if (++animationTimerCount == (2 * animationFramesPerSec)) {
        animationTimerCount = 0;
    }

    // Update the gradient for the next frame
    [self setGradientLocations:((CGFloat)animationTimerCount/(CGFloat)animationFramesPerSec)];
}

- (void)startTwinkle
{
	if (!_animationTimer) {
		animationTimerCount = 0;
		[self setGradientLocations:0];
		_animationTimer = [NSTimer 
						   scheduledTimerWithTimeInterval:1.0/animationFramesPerSec 
						   target:self 
						   selector:@selector(animationTimerFired:) 
						   userInfo:nil 
						   repeats:YES];
	}
}

- (void)stopTwinkle
{
	if (_animationTimer) {
		[_animationTimer invalidate];
        _animationTimer = nil;
	}
    [self.layer setNeedsDisplay];
}

@end
