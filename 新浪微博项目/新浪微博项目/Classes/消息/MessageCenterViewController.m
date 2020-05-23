//
//  MessageCenterViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "UITestedViewController.h"

@interface MessageCenterViewController ()

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.blueColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITestedViewController *testedVC = [[UITestedViewController alloc]init];
    [self.navigationController pushViewController:testedVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
