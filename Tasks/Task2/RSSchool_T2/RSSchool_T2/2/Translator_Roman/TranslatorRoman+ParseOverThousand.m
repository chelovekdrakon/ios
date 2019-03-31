//
//  TranslatorRoman+ParseOverThousand.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman+ParseOverThousand.h"

@implementation TranslatorRoman (ParseOverThousand)

- (NSMutableString *)parseOverThousand:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    double numberOfThousands = floor(number / 1000);
    
    for (int i = 0; i < numberOfThousands; i++) {
        [result appendString:[self.mapArabicToRoman valueForKey:@"1000"]];
    }
    
    return [result autorelease];
}

@end
