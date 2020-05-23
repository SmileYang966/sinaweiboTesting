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
