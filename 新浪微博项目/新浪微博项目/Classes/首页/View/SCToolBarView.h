//
//  SCToolBarView.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/7/1.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SCStatus;

@interface SCToolBarView : UIView

+(instancetype)toolBar;

@property(nonatomic,strong)SCStatus *status;



@end

NS_ASSUME_NONNULL_END
