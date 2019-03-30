#import "RomanTranslator.h"

#import "TranslatorRoman.h"

@implementation RomanTranslator

- (NSString *)romanFromArabic:(NSString *)arabicString { 
    TranslatorRoman *translator = [TranslatorRoman new];
    
    NSString *result = [translator translateToArabic:arabicString];
    [result retain];
    
    [translator release];
    
    return [result autorelease];
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    return @"";
}

// your code here
@end
