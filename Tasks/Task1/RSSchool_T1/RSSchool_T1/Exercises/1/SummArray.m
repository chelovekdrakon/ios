#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    double sum = 0;
    
    for (NSNumber *n in array) {
        sum += [n doubleValue];
    }
    
    return @(sum);
}

@end
