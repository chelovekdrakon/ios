//
//  TranslatorRoman+ParseThousand.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+ParseThousand.h"

@implementation TranslatorRoman (ParseThousand)

- (NSMutableString *)parseThousand:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    double numberOfHundreds = floor(number / 100);
    
    if (numberOfHundreds < 4) {
        for (int i = 0; i < numberOfHundreds; i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"100"]];
        }
    } else if (numberOfHundreds == 4) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"400"]];
    } else if (numberOfHundreds > 4 && numberOfHundreds < 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"500"]];
        
        for (int i = 0; i < (numberOfHundreds - 5); i++) {
            [result appendString:[self.mapArabicToRoman valueForKey:@"100"]];
        }
    } else if (numberOfHundreds == 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"900"]];
    } else {
        [result appendString:[self.mapArabicToRoman valueForKey:@"1000"]];
    }
    
    return [result autorelease];
}

@end
