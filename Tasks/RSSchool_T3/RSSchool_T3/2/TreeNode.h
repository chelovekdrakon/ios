//
//  TreeNode.h
//  RSSchool_T3
//
//  Created by Фёдор on 4/15/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject
@property(retain, nonatomic)TreeNode *right;
@property(retain, nonatomic)TreeNode *left;
@property(retain, nonatomic)NSNumber *value;
@end
