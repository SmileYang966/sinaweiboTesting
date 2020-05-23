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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        UIImage *img = [UIImage imageNamed:@"navigationbar_back"];
        UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,img.size.width, img.size.height)];
        [leftButton setBackgroundImage:img forState:UIControlStateNormal];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        [leftButton addTarget:self action:@selector(backItemAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *rightImg = [UIImage imageNamed:@"navigationbar_more"];
        UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,img.size.width, img.size.height)];
        [moreButton setBackgroundImage:rightImg forState:UIControlStateNormal];
        [moreButton setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreButton];
        [moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)backItemAction{
    [self popViewControllerAnimated:YES];
}

- (void)moreButtonAction{
    [self popToRootViewControllerAnimated:YES];
}


@end
