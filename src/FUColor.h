//
//  FUColor.h
//  OkudaKit
//
//  Created by Jeremy Agostino on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//	Stupid, dumbass abstraction layer for NSColor/UIColor

#import <Foundation/Foundation.h>

#if (TARGET_OS_IPHONE)
	#import <CoreText/CoreText.h>
#endif

@interface FUColor : NSObject
{
	id internalObj;
}

+ (FUColor *)blackColor;
+ (FUColor *)blueColor;
+ (FUColor *)brownColor;
+ (FUColor *)clearColor;
+ (FUColor *)cyanColor;
+ (FUColor *)darkGrayColor;
+ (FUColor *)grayColor;
+ (FUColor *)greenColor;
+ (FUColor *)lightGrayColor;
+ (FUColor *)magentaColor;
+ (FUColor *)orangeColor;
+ (FUColor *)purpleColor;
+ (FUColor *)redColor;
+ (FUColor *)whiteColor;
+ (FUColor *)yellowColor;
+ (FUColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (FUColor *)colorWithDeviceRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (CGFloat)redComponent;
- (CGFloat)greenComponent;
- (CGFloat)blueComponent;
- (CGFloat)alphaComponent;
- (void)set;

+ (FUColor *)wrap:(id)obj;
- (id)attribute;

@end

static inline NSString * FUForegroundColorAttributeName()
{
#if (TARGET_OS_IPHONE)
	return (NSString *)kCTForegroundColorAttributeName;
#else
	return NSForegroundColorAttributeName;
#endif
}

static inline NSString * FUBackgroundColorAttributeName()
{
#if (TARGET_OS_IPHONE)
	return (NSString *)@"background-color";
#else
	return NSBackgroundColorAttributeName;
#endif
}
