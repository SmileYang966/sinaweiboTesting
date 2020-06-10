//
//  HomeViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "HomeViewController.h"
#import "SCDropdownView.h"
#import "AccountModel.h"
#import "SCHomeTitleButton.h"

@interface HomeViewController ()<SCDropdownMenuDelegate>
@property(nonatomic,strong)UIButton *titleViewButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    //设置导航栏相关的内容
    [self setupNav];
    
    //设置用户信息相关
    [self setupUserInfo];
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" selectedImageName:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(scanSearch) imageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted"];
    
    
    AccountModel *account = [SCAccountTool fetchAccount];
    SCHomeTitleButton *titleViewButton = [[SCHomeTitleButton alloc]init];
    [titleViewButton setTitle:(account.name==nil ? @"首页" : account.name) forState:UIControlStateNormal];
    [titleViewButton addTarget:self action:@selector(titleViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleViewButton;
    self.titleViewButton = titleViewButton;
    
    /*
    UIButton *testedButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100,30)];
    testedButton.backgroundColor = UIColor.redColor;
    [self.view addSubview:testedButton];
    [testedButton addTarget:self action:@selector(testedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
     */
}

-(void)setupUserInfo{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AccountModel *accountModel = [SCAccountTool fetchAccount];
    NSString *accessToken = accountModel.access_token;
    NSString *uid = accountModel.uid;
    NSDictionary *dict = @{
        @"access_token" : accessToken,
        @"uid" : uid
    };
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        int a = 10;
        NSString *nameStr = responseObject[@"name"];
        accountModel.name = nameStr;
        //存进沙盒
        [SCAccountTool saveAccount:accountModel];
        
        
        [self.titleViewButton setTitle:nameStr forState:UIControlStateNormal];
        NSLog(@"responseObject=%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int  b = 20;
    }];
}

- (void)testedButtonClicked:(UIButton *)button{
    SCDropdownView *dropDownMenu = [SCDropdownView drowdownMenu];
    [dropDownMenu showFromView:button];
}

-(void)titleViewButtonClicked:(UIButton *)button{
    NSLog(@"titleViewButtonClicked");
    
    SCDropdownView *dropDownMenu = [SCDropdownView drowdownMenu];
    dropDownMenu.delegate = self;
    [dropDownMenu showFromView:button];
    
    UITableView *contentView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,200,217) style:UITableViewStyleGrouped];
    contentView.backgroundColor = UIColor.redColor;
    dropDownMenu.contentView = contentView;
    
}

- (void)dropDownMenuDisappearClicked{
    [self.titleViewButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

- (void)dropDownMenuAppearClicked{
    [self.titleViewButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)friendSearch{
    
}

-(void)scanSearch{
    
}

@end
