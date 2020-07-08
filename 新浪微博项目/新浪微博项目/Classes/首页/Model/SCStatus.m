//
//  SCStatus.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCStatus.h"
#import "SCUser.h"
#import "MJExtension.h"
#import "SCStatusPhoto.h"

@implementation SCStatus

- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [SCStatusPhoto class]};
}

- (NSString *)created_at{
    //刚刚
    //xx分钟前
    //xx小时前
    //昨天 xx:xx
    //xx-xx xx:xx
    //xxxx-xx-xx xx:xx
    
    /**
    1.今年
    1> 今天
    * 1分内： 刚刚
    * 1分~59分内：xx分钟前
    * 大于60分钟：xx小时前
    
    2> 昨天
    * 昨天 xx:xx
    
    3> 其他
    * xx-xx xx:xx
    
    2.非今年
    1> xxxx-xx-xx xx:xx
    */
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    NSDate *currentDate = [NSDate now];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:createdDate toDate:currentDate options:0];
    NSLog(@"comps = %@",comps);
    
    if([self isThisYear:createdDate]){
        if ([self isToday:createdDate]) {
            if (comps.hour>=1) {//1小时前
                return [NSString stringWithFormat:@"%ld小时前",(long)comps.hour];
            }else if(comps.minute>=1)//xx分钟前
            {
                return [NSString stringWithFormat:@"%ld分钟前",comps.minute];
            }else{
                return [NSString stringWithFormat:@"刚刚"];
            }
            
            
        }else if([self isYesterday:createdDate]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdDate];
        }else{//其它
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdDate];
        }
    }
    else{
        //非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    
    
    return @"123";
}


//是否为今年
-(BOOL)isThisYear:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowComps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateComps.year == nowComps.year;
}

//是否为昨天
-(BOOL)isYesterday:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =  [fmt stringFromDate:date];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *recordedDate = [fmt dateFromString:dateStr];
    NSDate *nowDate = [fmt dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:recordedDate toDate:nowDate options:0];
    return comps.year==0 && comps.month==0 && comps.day==1;
}

//是否为今天
-(BOOL)isToday:(NSDate *)date{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr =  [fmt stringFromDate:date];
    NSString *nowDateStr = [fmt stringFromDate:[NSDate date]];
    return [dateStr isEqualToString:nowDateStr];
}

@end
