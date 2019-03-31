//
//  TranslatorArabic.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorArabic.h"

@implementation TranslatorArabic

@synthesize mapRomanToArabic = _mapRomanToArabic;

- (id)init {
    self = [super init];
    if(self){
        _mapRomanToArabic = @{
            @"I"    :   @"1",

            @"IV"   :   @"4",
            @"V"    :   @"5",
            @"IX"   :   @"9",

            @"X"    :   @"10",

            @"XL"   :   @"40",
            @"L"    :   @"50",
            @"XC"   :   @"90",

            @"C"    :   @"100",

            @"CD"   :   @"400",
            @"D"    :   @"500",
            @"CM"   :   @"900",

            @"M"    :   @"1000",
        };
    }
    
    return self;
}

- (void)dealloc {
    // IS IT SECURE TO USE [...autorelease] VALUE AS PROPERTY?
    [super dealloc];
}

- (NSNumber *)summArray:(NSArray *)array {
    [array retain];
    
    double sum = 0;
    
    for (NSNumber *n in array) {
        sum += [n doubleValue];
    }
    
    [array release];
    
    return @(sum);
}

- (NSString *)translateToArabic:(NSString *)romanString {
    [romanString retain];
    
    NSMutableArray *resultArray = [NSMutableArray new];
    
    NSArray *sequencialRomanArray = @[@"M", @"CM", @"D", @"CD", @"C", @"XC", @"L", @"XL", @"X", @"IX", @"V", @"IV", @"I"];
    int searchPositionToStart = 0;
    
    for (NSString *glyph in sequencialRomanArray) {
        NSError *error = NULL;
        
        NSString *pattern = [[NSString alloc] initWithFormat:@"\\A(%@++)", glyph];
        
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern
                                                           options:NSRegularExpressionCaseInsensitive
                                                            error:&error];
        
        [pattern release];
        
        NSString *strToMatch = [romanString substringFromIndex:searchPositionToStart];
        
        NSArray *matches = [regex matchesInString:strToMatch
                                          options:0
                                            range:NSMakeRange(0, [strToMatch length])];
        
        [regex release];
        
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            
            searchPositionToStart = searchPositionToStart + (int)matchRange.length;
            
            for (int i = 0; i < (matchRange.length / glyph.length); i++) {
                [resultArray addObject:[_mapRomanToArabic valueForKey:glyph]];
            }
        }
        
        if (searchPositionToStart == romanString.length) {
            break;
        }
    }
    
    [romanString release];
    
    NSNumber *resultNumber = [self summArray:resultArray];
    NSString *result = [resultNumber stringValue];
    
    return result;
}

@end
