//
//  SCTabBar.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/29.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCTabBar.h"

@implementation SCTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //1.将button加入到self.tabBar中去，并设置其frame
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,64,44)];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)plusButtonClicked:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(scTabBarClickedPlusButton:)]) {
        [self.delegate scTabBarClickedPlusButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    //重新排布tabBar的位置
    int count = 5;
    NSLog(@"self.subViews.count=%ld",self.subviews.count);
    CGFloat width = self.width / count*1.0f;
    CGFloat height = self.height;
    CGFloat  tabBarButtonIndex = 0;
    for (UIView *subView in self.subviews) {
        
        //设置center的中心位置
        if ([subView isKindOfClass:[UIButton class]]) {
            NSLog(@"self.centerX is %f",self.centerX);
            subView.centerX = self.centerX;
        }
        
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
