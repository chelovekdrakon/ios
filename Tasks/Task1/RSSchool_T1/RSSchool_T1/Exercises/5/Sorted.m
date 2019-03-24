#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted

// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    ResultObject *value = [ResultObject new];
    
    NSArray<NSString *> *array = [string componentsSeparatedByString:@" "];
    
    value.status = NO;
    NSMutableArray<NSNumber *> *positions = [NSMutableArray new];
    
    for (int i = 0; i < [array count] - 1; i++) {
        if ([array[i] intValue] > [array[i + 1] intValue]) {
            value.status = YES;
            
            [positions addObject:@(i + 1)];
        }
    }
    
    if (value.status) {
        if ([positions count] == 2) {
            int secondNumber = [positions[1] intValue];
            
            NSString *str = [NSString stringWithFormat: @"swap %@ %i", positions[0], secondNumber + 1];
            
            value.detail = str;
        } else if ([array count] == 2) {
            value.detail = @"swap 1 2";
        } else if ([array count] == 3 && [positions count] == 1) {
            value.status = NO;
        } else {
            BOOL isPositionsSorted = YES;
            
            for (int i = 0; i < [positions count] - 1; i++) {
                double currValue = [[positions objectAtIndex:i] doubleValue];
                double nextValue = [[positions objectAtIndex:(i + 1)] doubleValue];
                
                if (currValue != (nextValue - 1)) {
                    isPositionsSorted = NO;
                    break;
                }
            }
            
            if (isPositionsSorted) {
                int secondNumber = [[positions lastObject] intValue];
                
                NSString *str = [NSString stringWithFormat: @"reverse %@ %i", positions[0], secondNumber + 1];
                
                value.detail = str;
            } else {
                value.status = NO;
            }
        }
    }
    
    return value;
}

@end
