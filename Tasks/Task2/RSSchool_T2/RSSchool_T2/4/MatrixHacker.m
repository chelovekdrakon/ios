#import "MatrixHacker.h"

typedef id<Character> (^HackerBlock)(NSString *name);


@interface MatrixHacker()
@property (nonatomic, copy) HackerBlock hackerBlock;
@end

@implementation MatrixHacker

- (void)injectCode:(id<Character> (^)(NSString *name))theBlock {
    _hackerBlock = theBlock;
}

- (NSArray<id<Character>> *)runCodeWithData:(NSArray<NSString *> *)names {
    [names retain];
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (NSString *name in names) {
        id<Character> ch = self.hackerBlock(name);
        [result addObject:ch];
    }
    
    [names release];
    
    return [result autorelease];
}

- (void)dealloc {
    [_hackerBlock release];
    [super dealloc];
}

@end
