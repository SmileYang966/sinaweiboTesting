//
//  SCUser.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCUser.h"

@implementation SCUser

+ (instancetype)userWithDict:(NSDictionary *)dict{
    SCUser *user = [[SCUser alloc]init];
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

@end
