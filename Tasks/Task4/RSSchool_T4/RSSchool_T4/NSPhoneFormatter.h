//
//  NSPhoneFormatter.h
//  RSSchool_T4
//
//  Created by Фёдор on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPhoneFormatter : NSObject
+ (NSString *)formatPhoneNumber:(NSString *)phoneNumber
                withCountryCode:(NSString *)countryCode
                          where:(int)subCodeLength
                            and:(int)firstBlockLength
                            and:(int)secondBlockLength
                            and:(NSString *)divider;
+ (NSString *)getPhoneNumberWithoutFormatting:(NSString *)str;
@end
