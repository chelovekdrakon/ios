//
//  MainViewController.m
//  RSSchool_T4
//
//  Created by Фёдор on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property(retain, nonatomic) UIView* mainView;
@property(retain, nonatomic) UIView* flagView;
@property(retain, nonatomic) UITextField* textField;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = self.view.bounds.size.width;
    
    CGFloat mainViewWidth = screenWidth - 50;
    CGFloat mainViewHeight = 100;
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(25, 100, mainViewWidth, mainViewHeight)];
    self.mainView = mainView;
    [mainView release];
    
    _mainView.layer.borderWidth = 1.f;
    _mainView.layer.borderColor = [UIColor blackColor].CGColor;
    _mainView.layer.cornerRadius = 5;

    [self.view addSubview:_mainView];
    
    CGFloat flagViewWidth = 50;
    CGFloat flagViewHeight = mainViewHeight - 50;
    CGFloat flagViewMargin = 10;
    
    UIView *flagView = [[UIView alloc] initWithFrame:CGRectMake(flagViewMargin, 25, flagViewWidth, flagViewHeight)];
    self.flagView = flagView;
    [flagView release];
    
    _flagView.layer.borderWidth = 1.f;
    _flagView.layer.borderColor = [UIColor blackColor].CGColor;
    _flagView.layer.cornerRadius = 2;
    
    [_mainView addSubview:_flagView];
    
    
    CGFloat textFieldpositionX = (_flagView.center.x + (_flagView.layer.frame.size.width / 2)) + flagViewMargin;
    CGFloat textFieldMarginRight = 10;
    CGFloat textFieldWidht = mainViewWidth - flagViewWidth - (flagViewMargin * 2) - textFieldMarginRight;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldpositionX, 25, textFieldWidht, mainViewHeight - 50)];
    self.textField = textField;
    [textField release];
    
    _textField.keyboardType = UIKeyboardTypePhonePad;
    _textField.textContentType = UITextContentTypeTelephoneNumber;
    [self setTextFieldBorder:_textField];
    
    [_mainView addSubview:_textField];
}

-(void)setTextFieldBorder:(UITextField *)textField {
    CALayer *border = [CALayer layer];
    
    CGFloat borderWidth = 2;
    
    border.borderColor = [UIColor blackColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    textField.layer.masksToBounds = YES;
    
    [textField.layer addSublayer:border];
}

@end
