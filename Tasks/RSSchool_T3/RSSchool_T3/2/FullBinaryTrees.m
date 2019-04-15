#import "FullBinaryTrees.h"

@implementation FullBinaryTrees : NSObject

- (NSArray *)getNodes:(NSInteger)count {
    NSMutableArray *resultArr = [NSMutableArray new];
    
    if (count == 1) {
        TreeNode *node = [TreeNode new];
        [resultArr addObject:node];
        [node release];
    } else if (count % 2 == 1) {
        for (int x = 0; x < count; x ++) {
            NSArray *leftTree = [self getNodes:x];
            [leftTree retain];
            
            for (TreeNode *leftNode in leftTree) {
                NSArray *rightTree = [self getNodes:(count - x - 1)];
                [rightTree retain];
                
                for (TreeNode *rightNode in rightTree) {
                    TreeNode *rootNode = [TreeNode new];
                    
                    [rootNode setValue:leftNode forKey:@"left"];
                    [rootNode setValue:rightNode forKey:@"right"];
                    
                    [resultArr addObject:rootNode];
                    
                    [rootNode release];
                }
                
                [rightTree release];
            }
            
            [leftTree release];
        }
    }
        
    return [resultArr autorelease];
}

- (NSString *)stringForNodeCount:(NSInteger)count {
    NSArray *resultArr = [self getNodes:count];
    NSString *result = [self parseArrayOfBST:resultArr];
    
    return result;
}

- (NSString *)parseArrayOfBST:(NSArray *)array {
    NSMutableArray *arr = [NSMutableArray new];
    
    for (TreeNode *node in array) {
        NSString *bst = [self printNode:node];
        NSString *bstAsArray = [NSString stringWithFormat:@"[%@]",bst];
        
        [arr addObject:bstAsArray];
    }
         
    return [NSString stringWithFormat:@"[%@]",arr];
}

- (NSString *)printNode:(TreeNode *)node {
    if ([node isKindOfClass:[TreeNode class]]) {
        NSString *leftNode = [self printNode:node.left];
        NSString *nodeValue = @"0";
        NSString *rightNode = [self printNode:node.right];
        
        NSString *result = [NSString stringWithFormat:@"%@,%@,%@", leftNode, rightNode, nodeValue];
        
        return result;
    } else {
        return @"null";
    }
}

//NSMutableArray *result = [[NSMutableArray new] autorelease];
//
//if ([node isKindOfClass:[TreeNode class]]) {
//    NSString *nodeValue = @"0";
//
//    if ([node.left isEqual:[NSNull null]] && [node.right isEqual:[NSNull null]]) {
//        [result addObject:nodeValue];
//    } else {
//        [result addObject:[self printNode:node.left]];
//        [result addObject:nodeValue];
//        [result addObject:[self printNode:node.right]];
//    }
//} else {
//    [result addObject:@"null"];
//}
//
//return [result componentsJoinedByString:@","];

- (NSString *)parseArray:(NSArray *)array {
    [array retain];
    
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
    
    [array release];
    
    NSString *result = [resultArray componentsJoinedByString:@","];
    [resultArray release];
    
    return [NSString stringWithFormat:@"[%@]", result];
}

@end
