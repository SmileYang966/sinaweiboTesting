//
//  SCToolBarView.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/7/1.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCToolBarView.h"
#import "SCStatus.h"

@interface SCToolBarView()

@property(nonatomic,weak)UIButton *retweetBtn;
@property(nonatomic,weak)UIButton *commentBtn;
@property(nonatomic,weak)UIButton *unlikeBtn;

@end

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
   self.retweetBtn =  [self setupButtonWithTitle:@"转发" icon:@"timeline_icon_retweet"];
   self.commentBtn = [self setupButtonWithTitle:@"评论" icon:@"timeline_icon_comment"];
   self.unlikeBtn = [self setupButtonWithTitle:@"赞" icon:@"timeline_icon_unlike"];
}

- (UIButton *)setupButtonWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0,0);
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self addSubview:btn];
    
    return btn;
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

- (void)setStatus:(SCStatus *)status{
    _status = status;
    status.attitudes_count = 121002;
    if (status.attitudes_count>0 && status.attitudes_count<10000) {
        [self.unlikeBtn setTitle:[NSString stringWithFormat:@"%d",status.attitudes_count] forState:UIControlStateNormal];
    }else if(status.attitudes_count>=10000){
        double wan = status.attitudes_count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万",wan];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [self.unlikeBtn setTitle:title forState:UIControlStateNormal];
    }
    
    if (status.comments_count>0 && status.comments_count<10000) {
        [self.commentBtn setTitle:[NSString stringWithFormat:@"%d",status.comments_count] forState:UIControlStateNormal];
    }else if(status.comments_count>=10000){
        double wan = status.comments_count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万",wan];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [self.commentBtn setTitle:title forState:UIControlStateNormal];
    }
    
    if (status.reposts_count>0 && status.reposts_count<10000) {
        [self.retweetBtn setTitle:[NSString stringWithFormat:@"%d",status.reposts_count] forState:UIControlStateNormal];
    }else if(status.reposts_count>=10000){
        double wan = status.reposts_count / 10000.0;
        NSString *title = [NSString stringWithFormat:@"%.1f万",wan];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [self.retweetBtn setTitle:title forState:UIControlStateNormal];
    }
}



@end
