//
//  FUColor.m
//  OkudaKit
//
//  Created by Jeremy Agostino on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FUColor.h"

#if (TARGET_OS_IPHONE)
#define OSSPECColor UIColor
#else
#define OSSPECColor NSColor
#endif

#define defColor(_clr) + (FUColor *)_clr { OSSPECColor * c = [OSSPECColor _clr]; return [FUColor wrap:c]; }

@implementation FUColor

defColor(blackColor)
defColor(blueColor)
defColor(brownColor)
defColor(clearColor)
defColor(cyanColor)
defColor(darkGrayColor)
defColor(grayColor)
defColor(greenColor)
defColor(lightGrayColor)
defColor(magentaColor)
defColor(orangeColor)
defColor(purpleColor)
defColor(redColor)
defColor(whiteColor)
defColor(yellowColor)

+ (FUColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
#if (TARGET_OS_IPHONE)
	UIColor * c = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
#else
	NSColor * c = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:alpha];
#endif
	return [FUColor wrap:c];
}

+ (FUColor *)colorWithDeviceRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
	return [FUColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (CGFloat)redComponent
{
#if (TARGET_OS_IPHONE)
	CGFloat ret;
	CGFloat junk;
	[internalObj getRed:&ret green:&junk blue:&junk alpha:&junk];
	return ret;
#else
	return [internalObj redComponent];
#endif
}

- (CGFloat)greenComponent
{
#if (TARGET_OS_IPHONE)
	CGFloat ret;
	CGFloat junk;
	[internalObj getRed:&junk green:&ret blue:&junk alpha:&junk];
	return ret;
#else
	return [internalObj greenComponent];
#endif
}

- (CGFloat)blueComponent
{
#if (TARGET_OS_IPHONE)
	CGFloat ret;
	CGFloat junk;
	[internalObj getRed:&junk green:&junk blue:&ret alpha:&junk];
	return ret;
#else
	return [internalObj blueComponent];
#endif
}

- (CGFloat)alphaComponent
{
#if (TARGET_OS_IPHONE)
	CGFloat ret;
	CGFloat junk;
	[internalObj getRed:&junk green:&junk blue:&junk alpha:&ret];
	return ret;
#else
	return [internalObj alphaComponent];
#endif
}

- (void)set
{
#if (TARGET_OS_IPHONE)
	[(UIColor *)internalObj set];
#else
	[(NSColor *)internalObj set];
#endif
}

+ (FUColor *)wrap:(id)obj
{
	FUColor * f = [FUColor new];
	if (f) f->internalObj = [obj retain];
	return [f autorelease];
}

- (id)attribute
{
#if (TARGET_OS_IPHONE)
	UIColor * u = (UIColor *)internalObj;
	return (id)u.CGColor;
#else
	return (NSColor *)internalObj;
#endif
}
@end
