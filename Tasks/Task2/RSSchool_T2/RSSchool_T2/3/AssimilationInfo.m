//
//  AssimilationInfo.m
//  RSSchool_T2
//
//  Created by Фёдор on 3/31/19.
//  Copyright © 2019 Alexander Shalamov. All rights reserved.
//

#import "AssimilationInfo.h"

@implementation AssimilationInfo

@synthesize years = _years;
@synthesize months = _months;
@synthesize weeks = _weeks;
@synthesize days = _days;
@synthesize hours = _hours;
@synthesize minutes = _minutes;
@synthesize seconds = _seconds;

- (NSDate *)getDate:(NSString *)dateString {
    NSRange rangeOfYear = NSMakeRange(0, 4);
    NSString *yearStr = [dateString substringWithRange:rangeOfYear];
    
    NSRange rangeOfMonth = NSMakeRange(5, 2);
    NSString *monthStr = [dateString substringWithRange:rangeOfMonth];
    
    NSRange rangeOfDay = NSMakeRange(8, 2);
    NSString *dayStr = [dateString substringWithRange:rangeOfDay];
    
    NSRange rangeOfHours = NSMakeRange([dateString length] - 2, 2);
    NSString *hoursStr = [dateString substringWithRange:rangeOfHours];
    
    NSRange rangeOfMinutes = NSMakeRange([dateString length] - 5, 2);
    NSString *minutesStr = [dateString substringWithRange:rangeOfMinutes];
    
    NSRange rangeOfSeconds = NSMakeRange([dateString length] - 8, 2);
    NSString *secondsStr = [dateString substringWithRange:rangeOfSeconds];
    
    NSString *stringDateFormatted = [NSString stringWithFormat:@"%@:%@:%@ %@:%@:%@",
                                     dayStr, monthStr, yearStr, hoursStr, minutesStr, secondsStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd:MM:yyyy HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:stringDateFormatted];
    
    [dateFormatter release];
    
    return date;
}

- (NSDate *)getAssimilationDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM dd, yyyy, HH:mm:ss"];
    
    NSDate *asimilationDate = [dateFormatter dateFromString:@"Sunday, August 14, 2208, 03:13:37"];
    
    return asimilationDate;
}

- (id)initWithDate:(NSString *)dateString {
    self = [super init];
    
    if (self) {
        NSDate *date = [self getDate:dateString];
        [date retain];
        
        NSDate *asimilationDate = [self getAssimilationDate];
        [asimilationDate retain];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date toDate:asimilationDate options: 0];
        
        _seconds = components.second;
        _minutes = components.minute;
        _hours = components.hour;
        _days = components.day;
        _months = components.month;
        _years = components.year;
        
        _weeks = 0;
    }
    
    return self;
}

- (void)dealloc {
//    _years = nil;
//    _months = nil;
//    _weeks = nil;
//    _days = nil;
//    _hours = nil;
//    _minutes = nil;
//    _seconds = nil;
    
    [super dealloc];
}

@end
