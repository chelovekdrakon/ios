//
//  UIGenerator.m
//  RSSchool_T3
//
//  Created by Фёдор on 4/14/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "UIGenerator.h"

@implementation UIGenerator

- (UIButton *)generateButtonOn:(NSArray *)positions withTitle:(NSString *)title {
    NSNumber *x = positions[0];
    NSNumber *y = positions[1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x.doubleValue, y.doubleValue, 130, 50)];
    
    button.backgroundColor = [UIColor yellowColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return [button autorelease];
}


- (UIView *)generateSubview {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 60, 325, 410)];
    view.backgroundColor = [UIColor blackColor];
    
    return [view autorelease];
}

- (UILabel *)generateLabelWithFormatter:(NSDateFormatter *)formatter {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 70)];
    
    NSString* text = [[NSString alloc] initWithString:[formatter stringFromDate:[NSDate date]]];
    
    label.backgroundColor = [UIColor redColor];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    
    return [label autorelease];
}

- (UITextField *)generateTextFieldOn:(NSNumber *)position withPlaceholder:(NSString *)placeholder {
    UITextField *textField = [[UITextField alloc]
                              initWithFrame:CGRectMake(20, position.doubleValue, 280, 50)];
    
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = placeholder;
    
    return [textField autorelease];
}

@end
