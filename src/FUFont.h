//
//  FUFont.h
//  OkudaKit
//
//  Created by Jeremy Agostino on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

#if (TARGET_OS_IPHONE)
	#import <CoreText/CoreText.h>
#endif

@interface FUFont : NSObject
{
	id internalObj;
}

+ (FUFont *)fontWithName:(NSString *)fontName size:(CGFloat)fontSize;
+ (FUFont *)userFixedPitchFontOfSize:(CGFloat)fontSize;
+ (FUFont *)boldSystemFontOfSize:(CGFloat)fontSize;

- (NSString *)familyName;
- (CGFloat)pointSize;

+ (FUFont *)wrap:(id)obj;
- (id)attribute;


@end


static inline NSString * FUFontAttributeName()
{
#if (TARGET_OS_IPHONE)
	return (NSString *)kCTFontAttributeName;
#else
	return NSFontAttributeName;
#endif
}