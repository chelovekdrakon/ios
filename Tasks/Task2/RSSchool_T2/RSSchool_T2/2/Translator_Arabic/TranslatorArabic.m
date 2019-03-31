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

@end
