//
//  SCStatus.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCStatus.h"
#import "SCUser.h"

@implementation SCStatus

+ (instancetype)statusWithDict:(NSDictionary *)dict{
    SCStatus *status = [[SCStatus alloc]init];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [SCUser userWithDict:dict[@"user"]];
    return status;
}

@end
