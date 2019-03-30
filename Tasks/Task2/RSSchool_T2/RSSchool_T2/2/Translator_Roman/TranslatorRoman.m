//
//  TranslatorRoman.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TranslatorRoman.h"
#import "TranslatorRoman+parseTen.h"

@implementation TranslatorRoman

@synthesize mapArabicToRoman = _mapArabicToRoman;

- (id)init {
    self = [super init];
    if(self){
        _mapArabicToRoman = @{
            @"1"    :   @"I",

            @"4"    :   @"IV",
            @"5"    :   @"V",
            @"9"    :   @"IX",

            @"10"   :   @"X",

            @"40"   :   @"XL",
            @"50"   :   @"L",
            @"90"   :   @"XC",

            @"100"  :   @"C",

            @"400"  :   @"CD",
            @"500"  :   @"D",
            @"900"  :   @"CM",

            @"1000" :   @"M",
        };
    }
    
    return self;
}

- (void)dealloc {
    // IS IT SECURE TO USE AUTORELEASE VALUE AS PROPERTY
    [super dealloc];
}

- (NSString *)translateToArabic:(NSString *)romanString {
    [romanString retain];
    
    NSMutableString *mutableResult = [self parseTen:[romanString doubleValue]];
    NSString * result = [NSString stringWithString:mutableResult];
    
    [romanString release];
    
    return result;
}

@end
