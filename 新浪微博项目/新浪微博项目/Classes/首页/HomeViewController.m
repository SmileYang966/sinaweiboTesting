//
//  HomeViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" selectedImageName:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(scanSearch) imageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted"];
    
    
    UIButton *titleViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,150,40)];
    [titleViewButton setTitle:@"iOS黑马学院" forState:UIControlStateNormal];
    [titleViewButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [titleViewButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];;
    titleViewButton.imageEdgeInsets = UIEdgeInsetsMake(0,130,0,0);
    titleViewButton.titleEdgeInsets = UIEdgeInsetsMake(0,0,0,20);
    [titleViewButton addTarget:self action:@selector(titleViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleViewButton;
}

-(void)titleViewButtonClicked:(UIButton *)button{
    NSLog(@"titleViewButtonClicked");
    
    //1.获取当前屏幕上最后一个window
    UIWindow *keyWindow = [[UIApplication sharedApplication].windows lastObject];
    
    //2.添加蒙板
    UIView *coverView = [[UIView alloc]initWithFrame:keyWindow.bounds];
    coverView.backgroundColor = UIColor.clearColor;
    [keyWindow addSubview:coverView];
    
    //3.注意图片的拉伸，只能是垂直方向的拉伸，水平方向不能拉伸，因为水平方向是有不规则图形的
    UIImageView *dropDownMenu = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2f,64,217, 217)];
    dropDownMenu.image = [UIImage imageNamed:@"popover_background"];
    [keyWindow addSubview:dropDownMenu];
    
    
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }
}

-(void)friendSearch{
    
}

-(void)scanSearch{
    
}

@end
