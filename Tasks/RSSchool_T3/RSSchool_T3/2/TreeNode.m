//
//  TreeNode.m
//  RSSchool_T3
//
//  Created by Фёдор on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = @(0);
        _left = [NSNull null];
        _right = [NSNull null];
    }
    return self;
}

@end
