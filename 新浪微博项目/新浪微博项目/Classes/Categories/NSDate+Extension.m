//
//  NSDate+Extension.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/7/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "NSDate+Extension.h"



@implementation NSDate (Extension)

//是否为今年
-(BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowComps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateComps.year == nowComps.year;
}

//是否为昨天
-(BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =  [fmt stringFromDate:self];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *recordedDate = [fmt dateFromString:dateStr];
    NSDate *nowDate = [fmt dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:recordedDate toDate:nowDate options:0];
    return comps.year==0 && comps.month==0 && comps.day==1;
}

//是否为今天
-(BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =  [fmt stringFromDate:self];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    return [dateStr isEqualToString:nowDateStr];
}


@end
