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
@property(retain, nonatomic) UIView* flagImage;
@property(retain, nonatomic) UITextField* textField;
@property(retain, nonatomic) NSDictionary* countryCodes;
@property(retain, nonatomic) NSCharacterSet* phoneCharacterSet;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.countryCodes = @{
              @"77"  : @"KZ", // should be before @"7" to avoid double match
              @"7"   : @"RU",
              @"373" : @"MD",
              @"374" : @"AM",
              @"375" : @"BY",
              @"380" : @"UA",
              @"992" : @"TJ",
              @"993" : @"TM",
              @"994" : @"AZ",
              @"996" : @"KG",
              @"998" : @"UZ"
        };
        
        self.phoneCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789 +-#*()"];
    }
    
    return self;
}

- (void)dealloc {
    [_countryCodes release];
    [_textField release];
    [_mainView release];
    [_flagImage release];
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
    
    CGFloat flagImageWidth = 50;
    CGFloat flagImageHeight = mainViewHeight - 50;
    CGFloat flagImageMargin = 10;
    
    UIImageView* flagImage = [[UIImageView alloc] initWithFrame:CGRectMake(flagImageMargin, 25, flagImageWidth, flagImageHeight)];
    self.flagImage = flagImage;
    [flagImage release];
    
    _flagImage.layer.borderWidth = 1.f;
    _flagImage.layer.borderColor = [UIColor blackColor].CGColor;
    _flagImage.layer.cornerRadius = 2;
    
    [_mainView addSubview:_flagImage];
    
    
    CGFloat textFieldpositionX = (_flagImage.center.x + (_flagImage.layer.frame.size.width / 2)) + flagImageMargin;
    CGFloat textFieldMarginRight = 10;
    CGFloat textFieldWidht = mainViewWidth - flagImageWidth - (flagImageMargin * 2) - textFieldMarginRight;
    
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
    
    NSString *textInputValue = [NSString stringWithFormat:@"%@%@", textField.text, string];
    NSString *textInputPhoneNumber = [self getPhoneNumberWithoutFormatting:textInputValue];
//    [textInputPhoneNumber retain];
    
    NSMutableString *country = [[NSMutableString alloc] init];

    for (NSString* key in _countryCodes) {
        if ([textInputPhoneNumber hasPrefix:key]) {
            [country appendString:_countryCodes[key]];
            break;
        }
    }
    
    if (country.length) {
        [self drawFlag:country];
    }
    
    return YES;
}

- (void)drawFlag:(NSString *)country {
//    UIImage *image = [UIImage alloc] init
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
