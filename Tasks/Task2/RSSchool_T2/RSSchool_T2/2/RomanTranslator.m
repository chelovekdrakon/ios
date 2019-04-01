#import "RomanTranslator.h"

#import "TranslatorRoman.h"
#import "TranslatorArabic.h"

@implementation RomanTranslator

- (NSString *)romanFromArabic:(NSString *)arabicString {
    [arabicString retain];
    
    TranslatorRoman *translator = [TranslatorRoman new];
    
    NSString *result = [translator translateToRoman:arabicString];
    [result retain];
    
    [translator release];
    [arabicString release];
    
    return [result autorelease];
}

- (NSString *)arabicFromRoman:(NSString *)romanString {
    [romanString retain];

    TranslatorArabic *translator = [TranslatorArabic new];

    NSString *result = [translator translateToArabic:romanString];
    [result retain];

    [translator release];
    [romanString release];

    return [result autorelease];
}

@end
