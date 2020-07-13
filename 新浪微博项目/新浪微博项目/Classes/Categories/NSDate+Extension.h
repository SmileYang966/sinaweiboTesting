//
//  NSDate+Extension.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/7/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

//是否为今年
-(BOOL)isThisYear;

//是否为昨天
-(BOOL)isYesterday;

//是否为今天
-(BOOL)isToday;

@end

NS_ASSUME_NONNULL_END
