//
//  TranslatorRoman+Parser.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+Parser.h"

@implementation TranslatorRoman (Parser)

- (NSMutableString *)parseDigit:(double)number withMultiplier:(int)multiplier {
    NSMutableString *result = [NSMutableString new];
    
    double numberOfHundreds = floor(number / multiplier);
    
    if (numberOfHundreds < 4) {
        NSString *key = [NSString stringWithFormat:@"%i", (multiplier * 1)];
        
        for (int i = 0; i < numberOfHundreds; i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:key]];
        }
    } else if (numberOfHundreds == 4) {
        NSString *key = [NSString stringWithFormat:@"%i", (multiplier * 4)];
        
        [result appendString:[self.mapArabicToRoman valueForKey:key]];
    } else if (numberOfHundreds > 4 && numberOfHundreds < 9) {
        NSString *keyOne = [NSString stringWithFormat:@"%i", (multiplier * 1)];
        NSString *keyFive = [NSString stringWithFormat:@"%i", (multiplier * 5)];
        
        [result appendString:[self.mapArabicToRoman valueForKey:keyFive]];
        
        for (int i = 0; i < (numberOfHundreds - 5); i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:keyOne]];
        }
    } else if (numberOfHundreds == 9) {
        NSString *key = [NSString stringWithFormat:@"%i", (multiplier * 9)];
        
        [result appendString:[self.mapArabicToRoman valueForKey:key]];
    } else {
        NSString *key = [NSString stringWithFormat:@"%i", (multiplier * 10)];
        
        [result appendString:[self.mapArabicToRoman valueForKey:key]];
    }
    
    return [result autorelease];
}

@end
