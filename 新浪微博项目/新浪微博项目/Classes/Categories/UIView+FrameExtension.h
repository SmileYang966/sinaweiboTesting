//
//  UIView+FrameExtension.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FrameExtension)

@property(nonatomic,assign) CGFloat x;
@property(nonatomic,assign) CGFloat y;
@property(nonatomic,assign) CGFloat centerX;
@property(nonatomic,assign) CGFloat centerY;
@property(nonatomic,assign) CGSize size;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGPoint origin;

@end

NS_ASSUME_NONNULL_END
