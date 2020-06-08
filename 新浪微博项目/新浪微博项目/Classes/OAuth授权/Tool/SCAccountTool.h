//
//  SCAccountTool.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/9.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AccountModel;

@interface SCAccountTool : NSObject

+(void)saveAccount:(AccountModel *)account;
+(AccountModel *)fetchAccount;

@end

NS_ASSUME_NONNULL_END
