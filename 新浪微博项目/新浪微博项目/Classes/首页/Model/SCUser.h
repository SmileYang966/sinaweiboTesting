//
//  SCUser.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCUser : UIButton

/**    string    字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**    string    友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**    string    用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;


@end

NS_ASSUME_NONNULL_END
