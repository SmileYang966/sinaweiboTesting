//
//  SCTabBarViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCTabBarViewController.h"
#import "HomeViewController.h"
#import "MessageCenterViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "SCNavigationController.h"
#import "SCTabBar.h"

@interface SCTabBarViewController ()<SCTabBarDelegate>

@end

@implementation SCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init{
    if (self = [super init]) {
        //1.添加子控制器
        [self addChildNavController];

    }
    return self;
}


-(void)addChildNavController{
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self addViewControlerWithController:homeVC title:@"首页" tabBarItemImageName:@"tabbar_home" selectedTabBarItemImageName:@"tabbar_home_selected"];
    
    MessageCenterViewController *msgCenter = [[MessageCenterViewController alloc]init];
    [self addViewControlerWithController:msgCenter title:@"消息" tabBarItemImageName:@"tabbar_message_center" selectedTabBarItemImageName:@"tabbar_message_center_selected"];
    
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    [self addViewControlerWithController:discover title:@"发现" tabBarItemImageName:@"tabbar_discover" selectedTabBarItemImageName:@"tabbar_discover_selected"];
    
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addViewControlerWithController:profile title:@"我" tabBarItemImageName:@"tabbar_profile" selectedTabBarItemImageName:@"tabbar_profile_selected"];
    
    //2.使用KVC的方式去替换掉原有的tabBar，而使用自定义的SCTabBar
    SCLog(@"self.tabBar=%@",self.tabBar);
    SCTabBar *newDefinedTabBar = [[SCTabBar alloc]init];
    newDefinedTabBar.delegate = self;
    [self setValue:newDefinedTabBar forKey:@"tabBar"];
    SCLog(@"newDefinedTabBar=%@",newDefinedTabBar);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SCLog(@"self.tabBar.subviews=%@",self.tabBar.subviews);
}

-(void)addViewControlerWithController:(UIViewController *)controller title:(NSString *)title tabBarItemImageName:(NSString *)imageName selectedTabBarItemImageName:(NSString *)selectedImageName {
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    
    NSMutableDictionary *homeTextAttr = [NSMutableDictionary dictionary];
    homeTextAttr[NSForegroundColorAttributeName] = UIColor.orangeColor;
    [controller.tabBarItem setTitleTextAttributes:homeTextAttr forState:UIControlStateNormal];
    UIImage *homeSelectedImage = [UIImage imageNamed:selectedImageName];
    
    //选择image不去渲染图片
    controller.tabBarItem.selectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    SCNavigationController *nav = [[SCNavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}

-(void)scTabBarClickedPlusButton:(SCTabBar *)tabBar{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = UIColor.blueColor;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
