//
//  SCDropdownView.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/27.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCDropdownView : UIView

@property(nonatomic,strong) UIView *contentView;

+(instancetype)drowdownMenu;
-(void)show;

@end

NS_ASSUME_NONNULL_END
