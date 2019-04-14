#import "ArrayPrint.h"

@implementation NSArray (RSSchool_Extension_Name)

- (NSString *)print {
    return [self parseArray:self];
}

- (NSString *)parseArray:(NSArray *)array {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    for (NSObject *object in array) {
        if ([object isKindOfClass:[NSArray class]]) {
            [resultArray addObject:[self parseArray:(NSArray *)object]];
        } else if ([object isKindOfClass:[NSNumber class]]) {
            NSString *str = [NSString stringWithFormat:@"%@", object];
            [resultArray addObject: str];
        } else if ([object isKindOfClass:[NSNull class]]) {
            [resultArray addObject: @"null"];
        } else if ([object isKindOfClass:[NSString class]]) {
            NSString *str = [NSString stringWithFormat:@"\"%@\"", object];
            [resultArray addObject: str];
        } else {
            [resultArray addObject: @"unsupported"];
        }
    }
    
    NSString *result = [resultArray componentsJoinedByString:@","];
    [resultArray release];
    
    return [NSString stringWithFormat:@"[%@]", result];
}

@end
