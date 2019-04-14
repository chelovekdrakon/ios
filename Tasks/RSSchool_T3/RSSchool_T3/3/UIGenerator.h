//
//  UIGenerator.h
//  RSSchool_T3
//
//  Created by Фёдор on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGenerator : NSObject
- (UIButton *)generateButtonOn:(NSArray *)positions withTitle:(NSString *)title;
- (UIView *)generateSubview;
- (UILabel *)generateLabelWithFormatter:(NSDateFormatter *)formatter;
- (UITextField *)generateTextFieldOn:(NSNumber *)position withPlaceholder:(NSString *)placeholder;


@end

NS_ASSUME_NONNULL_END
