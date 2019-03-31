//
//  TranslatorRoman+parseHundred.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+ParseHundred.h"

@implementation TranslatorRoman (ParseHundred)

- (NSMutableString *)parseHundred:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    double numberOfDecimal = floor(number / 10);
    
    if (numberOfDecimal < 4) {
        for (int i = 0; i < numberOfDecimal; i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"10"]];
        }
    } else if (numberOfDecimal == 4) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"40"]];
    } else if (numberOfDecimal > 4 && numberOfDecimal < 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"50"]];
        
        for (int i = 0; i < (numberOfDecimal - 5); i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"10"]];
        }
    } else if (numberOfDecimal == 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"90"]];
    } else {
        [result appendString:[self.mapArabicToRoman valueForKey:@"100"]];
    }
    
    return [result autorelease];
}


@end
