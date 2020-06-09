//
//  accountModel.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/7.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountModel : NSObject<NSCoding>

@property(nonatomic,copy) NSString *access_token;
@property(nonatomic,copy) NSString *expires_in;
@property(nonatomic,assign) BOOL isRealName;
@property(nonatomic,copy) NSString *remind_in;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,strong) NSDate *createTime;
@property(nonatomic,copy) NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;



@end

NS_ASSUME_NONNULL_END
