#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    [array retain];
    
    double sum = 0;
    
    for (NSNumber *n in array) {
        sum += [n doubleValue];
    }
    
    [array release];
    
    return @(sum);
}

@end
