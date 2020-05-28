//
//  SCDropdownView.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/27.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCDropdownView.h"


@interface  SCDropdownView()
@property(nonatomic,strong) UIImageView *containerView;
@end

@implementation SCDropdownView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}


+(instancetype)drowdownMenu{
    //1/创建一个遮盖view
    return [[self alloc]init];
}


-(void)showFromView:(UIView *)view{
    //1.获得最上层的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.加上一层遮罩,避免点击其它事件
    self.frame = window.bounds;
    [window addSubview:self];
    
    //3.添加containerView
    self.containerView = [[UIImageView alloc]init];
    self.containerView.image = [UIImage imageNamed:@"popover_background"];
    self.containerView.width = 217;
    self.containerView.height = 217;
    [self addSubview:self.containerView];
    
    //4.转换坐标系
    CGRect newFrame = [view.superview convertRect:view.frame toView:window];
    self.containerView.y = newFrame.origin.y + 30;
    self.containerView.centerX = newFrame.origin.x+newFrame.size.width*0.5f;
}

- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    [self.containerView addSubview:contentView];
    
    CGFloat contentWidth = contentView.frame.size.width;
    CGFloat contentHeight = contentView.frame.size.height;
    
    //根据contentView的frame反过来设计containerView的容量大小
    CGFloat marginX = 10;
    CGFloat marginY = 15;
//    self.containerView.width = contentWidth + 2*marginX;
    self.containerView.height = contentHeight + 2*marginY;
    contentView.x = marginX;
    contentView.y = marginY;
    contentView.width = self.containerView.width - 2*marginX;
}

-(void)dismissView{
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissView];
}

@end
