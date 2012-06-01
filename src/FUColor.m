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

@implementation FUColor

+ (FUColor *)blackColor	{ 	OSSPECColor * c = [OSSPECColor blackColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)blueColor	{ 	OSSPECColor * c = [OSSPECColor blueColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)brownColor	{ 	OSSPECColor * c = [OSSPECColor brownColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)clearColor	{ 	OSSPECColor * c = [OSSPECColor clearColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)cyanColor	{ 	OSSPECColor * c = [OSSPECColor cyanColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)darkGrayColor	{ 	OSSPECColor * c = [OSSPECColor darkGrayColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)grayColor	{ 	OSSPECColor * c = [OSSPECColor grayColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)greenColor	{ 	OSSPECColor * c = [OSSPECColor greenColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)lightGrayColor	{ 	OSSPECColor * c = [OSSPECColor lightGrayColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)magentaColor	{ 	OSSPECColor * c = [OSSPECColor magentaColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)orangeColor	{ 	OSSPECColor * c = [OSSPECColor orangeColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)purpleColor	{ 	OSSPECColor * c = [OSSPECColor purpleColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)redColor	{ 	OSSPECColor * c = [OSSPECColor redColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)whiteColor	{ 	OSSPECColor * c = [OSSPECColor whiteColor]; 	return [FUColor wrap:c]; }
+ (FUColor *)yellowColor	{ 	OSSPECColor * c = [OSSPECColor yellowColor]; 	return [FUColor wrap:c]; }

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
