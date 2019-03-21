#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
    NSString *alphbetStr = @"q w e r t y u i o p a s d f g h j k l z x c v b n m";
    NSArray *alphbetArr = [alphbetStr componentsSeparatedByString:@" "];
    
    BOOL result = YES;
    
    for (NSString *letter in alphbetArr) {
        if (![string localizedCaseInsensitiveContainsString:letter]) {
            result = NO;
            break;
        }
    }
    
    return result;
}

@end
