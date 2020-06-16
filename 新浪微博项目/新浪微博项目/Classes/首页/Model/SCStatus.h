//
//  SCStatus.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCUser;

NS_ASSUME_NONNULL_BEGIN

@interface SCStatus : UIButton

/**    string    字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**    string    微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**    object    微博作者的用户信息字段 详细*/
@property (nonatomic, strong) SCUser *user;


@end

NS_ASSUME_NONNULL_END
