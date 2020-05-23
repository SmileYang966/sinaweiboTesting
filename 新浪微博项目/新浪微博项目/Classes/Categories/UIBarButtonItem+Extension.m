//
//  UIBarButtonItem+Extension.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)


+(UIBarButtonItem *)barButtonwithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName selectedImageName:(NSString *)highlightedImage{
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,0,image.size.width,image.size.height)];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    return barButtonItem;
}

@end
