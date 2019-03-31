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
        NSMutableString *str = [NSMutableString new];
        
        for (int i = 0; i < number; i++) {
            NSLog(@"");
            [str appendString:[self.mapArabicToRoman valueForKey:@"1"]];
        }
        
        [result appendString:str];
        [str release];
    } else if (number == 4) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"4"]];
    } else if (number > 4 && number < 9) {
        NSMutableString *str = [NSMutableString new];
        [str appendString:[self.mapArabicToRoman valueForKey:@"5"]];
        
        for (int i = 0; i < (number - 5); i++) {
            [str appendString:[self.mapArabicToRoman valueForKey:@"1"]];
        }
        
        [result appendString:str];
        [str release];
    } else if (number == 9) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"9"]];
    } else {
        [result appendString:[self.mapArabicToRoman valueForKey:@"10"]];
    }
    
    return [result autorelease];
}

@end
