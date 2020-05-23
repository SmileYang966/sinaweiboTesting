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
}

-(void)friendSearch{
    
}

-(void)scanSearch{
    
}

@end
