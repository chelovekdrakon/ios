//
//  TranslatorRoman+parseTen.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+ParseTen.h"

@implementation TranslatorRoman (ParseTen)

- (NSMutableString *)parseTen:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    if (number < 4) {
        for (int i = 0; i < number; i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"1"]];
        }
    } else if (number == 4) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"4"]];
    } else if (number > 4 && number < 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"5"]];
        
        for (int i = 0; i < (number - 5); i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"1"]];
        }
    } else if (number == 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"9"]];
    } else {
        [result appendString:[self.mapArabicToRoman valueForKey:@"10"]];
    }
    
    return [result autorelease];
}

@end
