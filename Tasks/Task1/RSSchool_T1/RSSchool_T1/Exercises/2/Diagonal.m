#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    double primarySumm = 0;
    double secondarySumm = 0;
    
    NSInteger faceLength = [array count];
    
    for (int i = 0; i < faceLength; i++) {
        NSString *string = [array objectAtIndex:i]; // will be autoreleased
        NSArray<NSString *> *subArray = [string componentsSeparatedByString: @" "]; // will be autoreleased
        
        primarySumm += [[subArray objectAtIndex:i] doubleValue];
        
        NSUInteger secondaryIndex = (faceLength - 1) - i;
        secondarySumm += [[subArray objectAtIndex:secondaryIndex] doubleValue];
        
//        secondaryIndex = nil;
    }
    
//    faceLength = nil;
    
    return @(fabs(primarySumm - secondarySumm));
}

@end
