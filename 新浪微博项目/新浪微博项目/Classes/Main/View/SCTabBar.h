//
//  SCTabBar.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/29.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SCTabBar;

@protocol SCTabBarDelegate <UITabBarDelegate>

-(void)scTabBarClickedPlusButton:(SCTabBar *)tabBar;

@end

@interface SCTabBar : UITabBar

@property(nonatomic,weak) id<SCTabBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
