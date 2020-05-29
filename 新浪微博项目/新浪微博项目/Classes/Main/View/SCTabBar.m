//
//  SCTabBar.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/29.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCTabBar.h"

@implementation SCTabBar

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //重新排布tabBar的位置
    int count = 5;
    NSLog(@"self.subViews.count=%ld",self.subviews.count);
    CGFloat width = self.width / count*1.0f;
    CGFloat height = self.height;
    CGFloat  tabBarButtonIndex = 0;
    for (UIView *subView in self.subviews) {
        Class classStr = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:classStr]) {
            subView.width = width;
            subView.height = height;
            subView.x = width * tabBarButtonIndex;
            
            tabBarButtonIndex++;
            if (tabBarButtonIndex==2) {
                tabBarButtonIndex++;
            }
        }
    }
}

@end
