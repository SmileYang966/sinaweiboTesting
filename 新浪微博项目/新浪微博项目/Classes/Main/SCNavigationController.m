//
//  SCNavigationController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCNavigationController.h"

@interface SCNavigationController ()

@end

@implementation SCNavigationController

+ (void)initialize{
    [super initialize];
    
    //统一设置UINavigationController上UIBarButtonItem的normal模式、高亮模式以及disable模式下的样式设置
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSForegroundColorAttributeName] = UIColor.orangeColor;
    dictM[NSFontAttributeName] = [UIFont systemFontOfSize:13.0f];
    [item setTitleTextAttributes:dictM forState:UIControlStateNormal];


    NSMutableDictionary *dictMHighlighted = [NSMutableDictionary dictionary];
    dictMHighlighted[NSFontAttributeName] = [UIFont systemFontOfSize:13.0f];
    dictMHighlighted[NSForegroundColorAttributeName] = UIColor.redColor;
    [item setTitleTextAttributes:dictMHighlighted forState:UIControlStateHighlighted];

    NSMutableDictionary *disabledStatus = [NSMutableDictionary dictionary];
    disabledStatus[NSFontAttributeName] = [UIFont systemFontOfSize:13.0f];
    disabledStatus[NSForegroundColorAttributeName] = UIColor.lightGrayColor;
    [item setTitleTextAttributes:disabledStatus forState:UIControlStateDisabled];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(backItemAction) imageName:@"navigationbar_back" selectedImageName:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(moreButtonAction) imageName:@"navigationbar_more" selectedImageName:@"navigationbar_more_highlighted"];
    }
}

- (void)backItemAction{
    [self popViewControllerAnimated:YES];
}

- (void)moreButtonAction{
    [self popToRootViewControllerAnimated:YES];
}


@end
