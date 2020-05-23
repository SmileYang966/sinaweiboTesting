//
//  UITestedViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "UITestedViewController.h"

@interface UITestedViewController ()

@end

@implementation UITestedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.redColor;
    
    UIImage *img = [UIImage imageNamed:@"navigationbar_back"];
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,img.size.width, img.size.height)];
    [leftButton setBackgroundImage:img forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
}


@end
