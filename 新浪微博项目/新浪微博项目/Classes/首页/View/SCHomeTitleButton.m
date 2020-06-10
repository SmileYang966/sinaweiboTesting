//
//  SCHomeTitleButton.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/10.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCHomeTitleButton.h"
#import "AccountModel.h"

@implementation SCHomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initButton];
    }
    return self;
}

-(void)initButton{
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    self.imageView.contentMode = UIViewContentModeCenter;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //如果仅仅是调整位置，即需要在layoutSubView里面调整位置即可，不需要设置titleLabelRect等方法
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
}

@end
