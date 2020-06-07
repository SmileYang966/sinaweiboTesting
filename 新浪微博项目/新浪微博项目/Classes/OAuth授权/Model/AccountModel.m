
//
//  accountModel.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/7.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    AccountModel *accountModel = [[AccountModel alloc]init];
    accountModel.access_token = dict[@"access_token"];
    accountModel.expires_in = dict[@"expires_in"];
    accountModel.remind_in = dict[@"remind_in"];
    accountModel.uid = dict[@"uid"];
    accountModel.isRealName = dict[@"isRealName"];
    
    return accountModel;
}

//归档进沙盒调用
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeBool:self.isRealName forKey:@"isRealName"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.isRealName = [decoder decodeObjectForKey:@"isRealName"];
    }
    return self;
}


@end
