//
//  FUFont.m
//  OkudaKit
//
//  Created by Jeremy Agostino on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FUFont.h"

@implementation FUFont

+ (FUFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
#if (TARGET_OS_IPHONE)
	UIFont * f = [UIFont fontWithName:fontName size:fontSize];
#else
	NSFont * f = [NSFont fontWithName:fontName size:fontSize];
#endif
	return [FUFont wrap:f];
}

+ (FUFont *)userFixedPitchFontOfSize:(CGFloat)fontSize
{
#if (TARGET_OS_IPHONE)
	UIFont * f = [UIFont fontWithName:@"Monaco" size:fontSize];
#else
	NSFont * f = [NSFont userFixedPitchFontOfSize:fontSize];
#endif
	return [FUFont wrap:f];
}

+ (FUFont *)boldSystemFontOfSize:(CGFloat)fontSize
{
#if (TARGET_OS_IPHONE)
	UIFont * f = [UIFont boldSystemFontOfSize:fontSize];
#else
	NSFont * f = [NSFont boldSystemFontOfSize:fontSize];
#endif
	return [FUFont wrap:f];
}

- (NSString *)familyName
{
	return [internalObj familyName];
}

- (CGFloat)pointSize
{
	return [internalObj pointSize];
}

+ (FUFont *)wrap:(id)obj
{
	FUFont * f = [FUFont new];
	if (f) f->internalObj = [obj retain];
	return [f autorelease];
}

- (id)attribute
{
#if (TARGET_OS_IPHONE)
	UIFont * u = (UIFont *)internalObj;
	CTFontRef ctFont = CTFontCreateWithName((CFStringRef)u.fontName, u.pointSize, NULL);
	return [(id)ctFont autorelease];
#else
	return (NSFont *)internalObj;
#endif
}

@end
