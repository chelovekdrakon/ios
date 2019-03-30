#import "RomanTranslator.h"

@interface RomanTranslator ()
@property(nonatomic, strong) NSDictionary *mapArabicToRoman;
@end

@implementation RomanTranslator
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
            @"900" :   @"CM",
            
            @"1000" :   @"M",
        };
    }
    
    return self;
}

- (void)dealloc {
    [_mapArabicToRoman release];
}

- (NSString *)romanFromArabic:(NSString *)arabicString {
    NSMutableString *result = [self parseTen:[arabicString doubleValue]];
    [result retain];
    
    return [result autorelease];
}

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

- (NSMutableString *)parseTen:(double)number {
    NSMutableString *result = [NSMutableString new];
    
    if (number < 4) {
        NSMutableString *str = [NSMutableString new];
        
        for (int i = 0; i < number; i++) {
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

- (NSString *)arabicFromRoman:(NSString *)romanString {
    return @"";
}

// your code here
@end
