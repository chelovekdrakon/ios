#import "KidnapperNote.h"

@implementation KidnapperNote

- (BOOL)checkMagazine:(NSString *)magaine note:(NSString *)note {
    [magaine retain];
    [note retain];
    
    BOOL result = YES;
    
    NSMutableString *mutableMagaine = [NSMutableString stringWithString:magaine];
    [magaine release];
    
    NSArray *array = [note componentsSeparatedByString:@" "];
    [note release];
    
    for (int i = 0; i < array.count; i++) {
        NSString *word = array[i];
        
        NSRange range = [mutableMagaine localizedStandardRangeOfString:word];
        
        if (range.length == 0) {
            result = NO;
            break;
        } else {
            [mutableMagaine deleteCharactersInRange:range];
        }
    }
    
    return result;
}

@end
