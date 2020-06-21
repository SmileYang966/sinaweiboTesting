//
//  SCStatusFrame.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/21.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SCStatus;

@interface SCStatusFrame : NSObject

@property(nonatomic,strong)SCStatus *status;

/**原创微博整体*/
@property(nonatomic,assign)CGRect originalViewF;

/**图标*/
@property(nonatomic,assign)CGRect iconF;

/**微博名称*/
@property(nonatomic,assign)CGRect nameLabelF;

/**是否是vip，如果是显示vip标示*/
@property(nonatomic,assign)CGRect vipViewF;

/**微博发送时间label*/
@property(nonatomic,assign)CGRect timeLabelF;

/**微博来源label*/
@property(nonatomic,assign)CGRect sourceLabelF;

/**正文*/
@property(nonatomic,assign)CGRect contentLabelF;

/**正文的imageView*/
@property(nonatomic,assign)CGRect contentImageViewF;


@property(nonatomic,assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
