#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
    double primarySumm = 0;
    double secondarySumm = 0;
    
    NSInteger faceLength = [array count];
    
    for (int i = 0; i < faceLength; i++) {
        NSString *string = [array objectAtIndex:i];
        NSArray<NSString *> *subArray = [string componentsSeparatedByString: @" "];
        
        primarySumm += [[subArray objectAtIndex:i] doubleValue];
        
        NSUInteger secondaryIndex = (faceLength - 1) - i;
        secondarySumm += [[subArray objectAtIndex:secondaryIndex] doubleValue];
    }
    
    return @(fabs(primarySumm - secondarySumm));
}

@end
