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
@property(retain, nonatomic) UIImageView* flagImageView;
@property(retain, nonatomic) UITextField* textField;
@property(retain, nonatomic) NSArray* countryCodes;
@property(retain, nonatomic) NSArray* countries;
@property(retain, nonatomic) NSCharacterSet* phoneCharacterSet;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // @"77" should be before @"7" to avoid double match
        self.countryCodes = @[@"77", @"7", @"373", @"374", @"375", @"380", @"992", @"993", @"994", @"996", @"998"];
        self.countries    = @[@"KZ", @"RU",@"MD",  @"AM",  @"BY",  @"UA",  @"TJ",  @"TM",  @"AZ",  @"KG",  @"UZ"];
        
        self.phoneCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 +-#*()"];
    }
    
    return self;
}

- (void)dealloc {
    [_countryCodes release];
    [_countries release];
    [_textField release];
    [_mainView release];
    [_flagImageView release];
    [_phoneCharacterSet release];
    
    [super dealloc];
}

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
    
    CGFloat flagImageViewWidth = 50;
    CGFloat flagImageViewHeight = mainViewHeight - 50;
    CGFloat flagImageViewMargin = 10;
    
    UIImageView* flagImageView = [[UIImageView alloc] initWithFrame:CGRectMake(flagImageViewMargin, 25, flagImageViewWidth, flagImageViewHeight)];
    self.flagImageView = flagImageView;
    [flagImageView release];
    
    _flagImageView.layer.borderWidth = 1.f;
    _flagImageView.layer.borderColor = [UIColor blackColor].CGColor;
    _flagImageView.layer.cornerRadius = 2;
    
    [_mainView addSubview:_flagImageView];
    
    
    CGFloat textFieldpositionX = (_flagImageView.center.x + (_flagImageView.layer.frame.size.width / 2)) + flagImageViewMargin;
    CGFloat textFieldMarginRight = 10;
    CGFloat textFieldWidht = mainViewWidth - flagImageViewWidth - (flagImageViewMargin * 2) - textFieldMarginRight;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldpositionX, 25, textFieldWidht, mainViewHeight - 50)];
    self.textField = textField;
    [textField release];
    
    _textField.keyboardType = UIKeyboardTypePhonePad;
    _textField.textContentType = UITextContentTypeTelephoneNumber;
    [self setTextFieldBorder:_textField];
    
    _textField.delegate = (id)self;
    
    [_mainView addSubview:_textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(![_phoneCharacterSet isSupersetOfSet:[NSCharacterSet characterSetWithCharactersInString:string]]) {
        return NO;
    }
    
    BOOL result = NO;
    
    NSString *textFieldValue = string.length
        ? [NSString stringWithFormat:@"%@%@", textField.text, string]
        : [textField.text substringToIndex:(textField.text.length - range.length)];
    
    NSString *textFieldPhoneNumber = [self getPhoneNumberWithoutFormatting:textFieldValue];
    [textFieldPhoneNumber retain];
    
    NSMutableString *country = [[NSMutableString alloc] init];
    
    for (int i = 0; i < _countryCodes.count; i++) {
        if ([textFieldPhoneNumber hasPrefix:_countryCodes[i]]) {
            [country appendString:_countries[i]];
            break;
        }
    }
    
    if (country.length) {
        if (country.length < 4) {
            _flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", country]];
        }
        
        [self formatTextField:textFieldPhoneNumber];
    } else {
        _flagImageView.image = nil;
        
        if (textFieldPhoneNumber.length <= 12) {
            result = YES;
        }
    }
    
    [textFieldPhoneNumber release];
    [country release];
    
    return result;
}

- (void)formatTextField:(NSString *)phoneNumber {
    _textField.text = phoneNumber;
}

- (NSString *)getPhoneNumberWithoutFormatting:(NSString *)str {
    NSError *error = NULL;
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\d" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:str
                                      options:0
                                        range:NSMakeRange(0, [str length])];
    
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        NSString *subStr = [str substringWithRange:matchRange];
        [result appendString:subStr];
    }
    
    [regex release];
    
    return [result autorelease];
}

- (void)setTextFieldBorder:(UITextField *)textField {
    CALayer *border = [CALayer layer];
    
    CGFloat borderWidth = 2;
    
    border.borderColor = [UIColor blackColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    textField.layer.masksToBounds = YES;
    
    [textField.layer addSublayer:border];
}

@end
