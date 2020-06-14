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

@interface HomeViewController ()<SCDropdownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *titleViewButton;
@property(nonatomic,strong)AccountModel *accountModel;
@property(nonatomic,strong)UITableView *tableView;

//TableView datasource
@property(nonatomic,strong)NSMutableArray *statuses;
@end

@implementation HomeViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 64.0f;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self tableView];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    //1.设置导航栏相关的内容
    [self setupNav];
    
    //2.设置用户信息相关
    [self setupUserInfo];
    
    //3.请求最新的数据
    [self loadData];
}

- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(friendSearch) imageName:@"navigationbar_friendsearch" selectedImageName:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonwithTarget:self action:@selector(scanSearch) imageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted"];
    
    
    AccountModel *account = [SCAccountTool fetchAccount];
    self.accountModel = account;
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


-(void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.accountModel.access_token forKey:@"access_token"];
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *array = responseObject[@"statuses"];
        for (NSDictionary *dict in array) {
            [self.statuses addObject:dict];
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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


#pragma mark Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statuses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    NSDictionary *dict = self.statuses[indexPath.row];
    cell.textLabel.text = dict[@"text"];
    
    return cell;
}

@end
