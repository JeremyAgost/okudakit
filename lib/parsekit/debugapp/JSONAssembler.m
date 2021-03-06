//
//  JSONAssembler.m
//  ParseKit
//
//  Created by Todd Ditchendorf on 12/16/08.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import "JSONAssembler.h"
#import "NSArray+ParseKitAdditions.h"
#import "FUColor.h"
#import <ParseKit/ParseKit.h>

@implementation JSONAssembler

- (id)init {
    self = [super init];
    if (self != nil) {
        FUColor *textColor = [FUColor whiteColor];
        FUColor *tagColor = [FUColor colorWithDeviceRed:.70 green:.14 blue:.53 alpha:1.];
        FUColor *attrNameColor = [FUColor colorWithDeviceRed:.33 green:.45 blue:.48 alpha:1.];
        FUColor *attrValueColor = [FUColor colorWithDeviceRed:.77 green:.18 blue:.20 alpha:1.];
        FUColor *commentColor = [FUColor colorWithDeviceRed:.24 green:.70 blue:.27 alpha:1.];
        FUColor *piColor = [FUColor colorWithDeviceRed:.09 green:.62 blue:.74 alpha:1.];

        FUFont *monacoFont = [FUFont fontWithName:@"Monaco" size:11.];
            
        self.defaultAttrs      = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [textColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];
        self.objectAttrs       = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [tagColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];
        self.propertyNameAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [attrNameColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];
        self.valueAttrs        = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [attrValueColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];
        self.constantAttrs     = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [piColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];
        self.arrayAttrs        = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [commentColor attribute], FUForegroundColorAttributeName(),
                                  [monacoFont attribute], FUFontAttributeName,
                                  nil];

        self.displayString = [[[NSMutableAttributedString alloc] initWithString:@"" attributes:defaultAttrs] autorelease];
        
        self.comma = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"," floatValue:0];
        self.curly = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"{" floatValue:0];
        self.bracket = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"[" floatValue:0];
    }
    return self;
}


- (void)dealloc {
    self.displayString = nil;
    self.defaultAttrs = nil;
    self.objectAttrs = nil;
    self.arrayAttrs = nil;
    self.propertyNameAttrs = nil;
    self.valueAttrs = nil;
    self.constantAttrs = nil;
    self.comma = nil;
    self.curly = nil;
    self.bracket = nil;
    [super dealloc];
}


- (void)appendAttributedStringForObjects:(NSArray *)objs withAttrs:(id)attrs {
    for (id obj in objs) {
        NSAttributedString *as = [[NSAttributedString alloc] initWithString:[obj stringValue] attributes:attrs];
        [displayString appendAttributedString:as];
        [as release];
    }
}


- (void)consumeWhitespaceFrom:(PKAssembly *)a {
    NSMutableArray *whitespaceToks = [NSMutableArray array];
    PKToken *tok = nil;
    while (1) {
        tok = [a pop];
        if (PKTokenTypeWhitespace == tok.tokenType) {
            [whitespaceToks addObject:tok];
        } else {
            [a push:tok];
            break;
        }
    }
    
    if (whitespaceToks.count) {
        whitespaceToks = [whitespaceToks reversedMutableArray];
        [self appendAttributedStringForObjects:whitespaceToks withAttrs:defaultAttrs];
    }
}


- (void)didMatchSymbolChar:(PKAssembly *)a {
    NSArray *objs = [NSArray arrayWithObject:[a pop]];
    [self consumeWhitespaceFrom:a];
    [self appendAttributedStringForObjects:objs withAttrs:objectAttrs];
}


- (void)didMatchPropertyName:(PKAssembly *)a {
    NSArray *objs = [NSArray arrayWithObject:[a pop]];
    [self consumeWhitespaceFrom:a];
    [self appendAttributedStringForObjects:objs withAttrs:propertyNameAttrs];
}


- (void)didMatchString:(PKAssembly *)a {
    NSArray *objs = [NSArray arrayWithObject:[a pop]];
    [self consumeWhitespaceFrom:a];
    [self appendAttributedStringForObjects:objs withAttrs:arrayAttrs];
}


- (void)didMatchNumber:(PKAssembly *)a {
    NSArray *objs = [NSArray arrayWithObject:[a pop]];
    [self consumeWhitespaceFrom:a];
    [self appendAttributedStringForObjects:objs withAttrs:valueAttrs];
}


- (void)didMatchConstant:(PKAssembly *)a {
    NSArray *objs = [NSArray arrayWithObject:[a pop]];
    [self consumeWhitespaceFrom:a];
    [self appendAttributedStringForObjects:objs withAttrs:constantAttrs];
}


- (void)didMatchNull:(PKAssembly *)a { [self didMatchConstant:a]; }
- (void)didMatchTrue:(PKAssembly *)a { [self didMatchConstant:a]; }
- (void)didMatchFalse:(PKAssembly *)a { [self didMatchConstant:a]; }

- (void)didMatchColon:(PKAssembly *)a { [self didMatchSymbolChar:a]; }
- (void)didMatchComma:(PKAssembly *)a { [self didMatchSymbolChar:a]; }
- (void)didMatchOpenCurly:(PKAssembly *)a { [self didMatchSymbolChar:a]; }
- (void)didMatchCloseCurly:(PKAssembly *)a { [self didMatchSymbolChar:a]; }
- (void)didMatchOpenBracket:(PKAssembly *)a { [self didMatchSymbolChar:a]; }
- (void)didMatchCloseBracket:(PKAssembly *)a { [self didMatchSymbolChar:a]; }

@synthesize displayString;
@synthesize defaultAttrs;
@synthesize objectAttrs;
@synthesize arrayAttrs;
@synthesize propertyNameAttrs;
@synthesize valueAttrs;
@synthesize constantAttrs;
@synthesize comma;
@synthesize curly;
@synthesize bracket;
@end

