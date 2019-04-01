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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy:MM:dd@ss\\mm/HH"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    [dateFormatter release];
    
    return date;
}

- (NSDate *)getAssimilationDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMMM dd, yyyy, HH:mm:ss"];
    
    NSDate *asimilationDate = [dateFormatter dateFromString:@"Sunday, August 14, 2208, 03:13:37"];
    
    [dateFormatter release];
    
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

@end
