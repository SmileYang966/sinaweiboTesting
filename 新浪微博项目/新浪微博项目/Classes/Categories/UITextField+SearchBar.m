//
//  UITextField+SearchBar.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/25.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "UITextField+SearchBar.h"


@implementation UITextField (SearchBar)

+(UITextField *)searchBar{
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0,0, UIScreen.mainScreen.bounds.size.width, 48)];
    tf.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,48,48)];
    imgView.image = [UIImage imageNamed:@"search_bar"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    tf.leftView = imgView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    return tf;
}

@end
