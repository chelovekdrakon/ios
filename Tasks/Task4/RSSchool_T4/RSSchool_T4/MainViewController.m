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
@property(retain, nonatomic) NSDictionary* phoneNumbersLength;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        // @"77" should be before @"7" to avoid double match
        self.countryCodes = @[@"77", @"7", @"373", @"374", @"375", @"380", @"992", @"993", @"994", @"996", @"998"];
        self.countries    = @[@"KZ", @"RU",@"MD",  @"AM",  @"BY",  @"UA",  @"TJ",  @"TM",  @"AZ",  @"KG",  @"UZ"];
        self.phoneNumbersLength = @{
            @"KZ": @(10),
            @"RU": @(10),
            @"MD": @(8),
            @"AM": @(8),
            @"BY": @(9),
            @"UA": @(9),
            @"TJ": @(9),
            @"TM": @(8),
            @"AZ": @(9),
            @"KG": @(9),
            @"UZ": @(9)
        };
        
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
    [_phoneNumbersLength release];
    
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
    NSMutableString *countryCode = [[NSMutableString alloc] init];
    
    for (int i = 0; i < _countryCodes.count; i++) {
        NSString *code = _countryCodes[i];
        if ([textFieldPhoneNumber hasPrefix:code]) {
            [country appendString:_countries[i]];
            [countryCode appendString:code];
            break;
        }
    }
    
    if (country.length) {
        if (country.length < 4) {
            _flagImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"flag_%@", country]];
        }
        
        BOOL isLengthValid = [self validatePhoneLength:textFieldPhoneNumber fromCountry:country withCountryCode:countryCode];
        
        if (isLengthValid) {
            [self formatTextField:textFieldPhoneNumber fromCountry:country withCountryCode:countryCode];
        }
    } else {
        _flagImageView.image = nil;
        
        if (textFieldPhoneNumber.length <= 12) {
            result = YES;
        }
    }
    
    [textFieldPhoneNumber release];
    [country release];
    [countryCode release];
    
    return result;
}

- (BOOL)validatePhoneLength:(NSString *)phoneNumber fromCountry:(NSString *)country withCountryCode:(NSString *)countryCode {
    NSNumber *expectedLength = _phoneNumbersLength[country];
    
    return phoneNumber.length <= (expectedLength.doubleValue + countryCode.length);
}

- (void)formatTextField:(NSString *)phoneNumber fromCountry:(NSString *)country withCountryCode:(NSString *)countryCode {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSInteger expectedLength = [(NSNumber *)_phoneNumbersLength[country] integerValue];
    
    
    if (expectedLength == 10) {
        // +code (xxx) xxx xx xx
        [result appendString:[self formatPhoneNumber:phoneNumber withCountryCode:countryCode where:3 and:3 and:2 and:@" "]];
    } else if (expectedLength == 9) {
        // +code (xx) xxx-xx-xx
        [result appendString:[self formatPhoneNumber:phoneNumber withCountryCode:countryCode where:2 and:3 and:2 and:@"-"]];
    } else if (expectedLength == 8) {
        //  +code (xx) xxx-xxx
        [result appendString:[self formatPhoneNumber:phoneNumber withCountryCode:countryCode where:2 and:3 and:3 and:@"-"]];
    }
    
    _textField.text = result;
    [result release];
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNumber
                         withCountryCode:(NSString *)countryCode
                                   where:(int)subCodeLength
                                     and:(int)firstBlockLength
                                     and:(int)secondBlockLength
                                     and:(NSString *)divider {
    NSMutableString *result = [[NSMutableString alloc] init];
    NSUInteger inputLength = phoneNumber.length;
    NSUInteger codeLength = countryCode.length;
    
    if (inputLength <= codeLength) {
        [result appendString:[NSString stringWithFormat:@"+%@", phoneNumber]];
    } else if (inputLength <= codeLength + subCodeLength) {
        NSString *code = [phoneNumber substringToIndex:codeLength];
        NSString *subCode = [phoneNumber substringFromIndex:codeLength];
        [result appendString:[NSString stringWithFormat:@"+%@ %@", code, subCode]];
    } else if (inputLength <= codeLength + subCodeLength + firstBlockLength) {
        NSString *code = [phoneNumber substringToIndex:codeLength];
        NSString *subCode = [phoneNumber substringWithRange:NSMakeRange(codeLength, subCodeLength)];
        NSString *firstBlock = [phoneNumber substringFromIndex:(codeLength + subCodeLength)];
        NSString *str = [NSString stringWithFormat:@"+%@ (%@) %@", code, subCode, firstBlock];
        [result appendString:str];
    } else if (inputLength <= codeLength + subCodeLength + firstBlockLength + secondBlockLength) {
        NSString *code = [phoneNumber substringToIndex:codeLength];
        NSString *subCode = [phoneNumber substringWithRange:NSMakeRange(codeLength, subCodeLength)];
        NSString *firstBlock = [phoneNumber substringWithRange:NSMakeRange(codeLength + subCodeLength, firstBlockLength)];
        NSString *secondBLock = [phoneNumber substringFromIndex:(codeLength + subCodeLength + firstBlockLength)];
        NSString *str = [NSString stringWithFormat:@"+%@ (%@) %@%@%@", code, subCode, firstBlock, divider, secondBLock];
        [result appendString:str];
    } else {
        NSString *code = [phoneNumber substringToIndex:codeLength];
        NSString *subCode = [phoneNumber substringWithRange:NSMakeRange(codeLength, subCodeLength)];
        NSString *firstBlock = [phoneNumber substringWithRange:NSMakeRange(codeLength + subCodeLength, firstBlockLength)];
        NSString *secondBLock = [phoneNumber substringWithRange:NSMakeRange(codeLength + subCodeLength + firstBlockLength, secondBlockLength)];
        NSString *thirdBlock = [phoneNumber substringFromIndex:(codeLength + subCodeLength + firstBlockLength + secondBlockLength)];
        NSString *str = [NSString stringWithFormat:@"+%@ (%@) %@%@%@%@%@", code, subCode, firstBlock, divider, secondBLock, divider, thirdBlock];
        [result appendString:str];
    }
    
    return [result autorelease];
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
