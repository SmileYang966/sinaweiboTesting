//
//  SCToolBarView.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/7/1.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCToolBarView.h"

@implementation SCToolBarView

+(instancetype)toolBar{
    return [[SCToolBarView alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
    }
    return self;
}

- (void)setupSubviews{
    [self setupButtonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
    [self setupButtonWithTitle:@"评论" icon:@"timeline_icon_comment"];
    [self setupButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
}

- (void)setupButtonWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0,0);
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:btn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnWidth = self.width / self.subviews.count;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnWidth;
        btn.height = self.height;
        btn.x = i*btnWidth;
    }
}



@end
