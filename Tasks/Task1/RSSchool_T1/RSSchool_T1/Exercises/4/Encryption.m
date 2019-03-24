#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    double stringLength = [string length];
    double columnsAmount = ceil(sqrt(stringLength));
    
    NSMutableArray<NSString *> *resultArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < columnsAmount; i++) {
        NSMutableString *str = [[NSMutableString alloc] init];
        
        for (int k = 0; k < columnsAmount; k++) {
            NSUInteger position = ((columnsAmount * k) + i);
            
            if (position < stringLength) {
                unichar ch = [string characterAtIndex:position];
                NSString *letter = [NSString stringWithCharacters:&ch length:1];
                
                [str appendString:letter];
                
                [letter release];
            } else {
                break;
            }
        }
        
        [resultArray addObject:str];
        [str release]; // will it copy or share pointer?
    }
    
    NSString *result = [resultArray componentsJoinedByString:@" "];
    [resultArray release];
    
    return result; // will be autoreleased
}

@end
