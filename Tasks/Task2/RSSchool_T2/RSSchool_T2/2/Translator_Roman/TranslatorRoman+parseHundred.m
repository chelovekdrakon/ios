//
//  TranslatorRoman+parseHundred.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+parseHundred.h"

@implementation TranslatorRoman (parseHundred)

- (NSMutableString *)parseHundred:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    if (number < 40) {
        NSMutableString *str = [NSMutableString new];
        
        double numberOfDecimal = floor(number / 10);
        
        for (int i = 0; i < numberOfDecimal; i++) {
            [str appendString:[self.mapArabicToRoman valueForKey:@"10"]];
        }
        
        [result appendString:str];
        [result appendString:[self parseTen:(number - numberOfDecimal)]];
        
        [str release];
    } else if (number == 40) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"40"]];
    } else if (number > 40 && number < 90) {
        NSMutableString *str = [NSMutableString new];
        [str appendString:[self.mapArabicToRoman valueForKey:@"50"]];
        
        for (int i = 0; i < (number - 5); i++) {
            [str appendString:[self.mapArabicToRoman valueForKey:@"10"]];
        }
        
        [result appendString:str];
        [str release];
    } else if (number == 90) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"90"]];
    } else {
        [result appendString:[self.mapArabicToRoman valueForKey:@"100"]];
    }
    
    return [result autorelease];
}


@end
