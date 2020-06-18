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
#import "UIImageView+WebCache.h"

#import "SCUser.h"
#import "SCStatus.h"
#import "MJExtension.h"

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
    
    //4.添加下拉刷新控件
    [self addRefreshControl];
}

-(void)addRefreshControl{
    //1.添加下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
}

-(void)refreshValueChanged:(UIRefreshControl *)control{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //取出第一条微博数据的sinceId
    SCStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus != nil) {
        [params setValue:firstStatus.idstr forKey:@"since_id"];
    }
    [params setValue:self.accountModel.access_token forKey:@"access_token"];
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"statuses"];
        NSMutableArray *newestStatuses = [NSMutableArray array];
        NSLog(@"array is %@",array);
        for (NSDictionary *dict in array) {
            SCStatus *status = [SCStatus objectWithKeyValues:dict];
            [newestStatuses addObject:status];
        }
        
        //将最新获取到的数据加载到微博最前面
        NSRange range = NSMakeRange(0,newestStatuses.count);
        NSIndexSet *set = [[NSIndexSet alloc]initWithIndexesInRange:range];
        [self.statuses insertObjects:newestStatuses atIndexes:set];
        
        [self.tableView reloadData];
        
        //停止刷新数据
        [control endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //停止刷新数据
        [control endRefreshing];
    }];
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
        
        SCUser *user = [SCUser objectWithKeyValues:responseObject];
        NSString *nameStr = user.name;
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
        NSLog(@"array is %@",array);
        for (NSDictionary *dict in array) {
            SCStatus *status = [SCStatus objectWithKeyValues:dict];
            [self.statuses addObject:status];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    SCStatus *status = self.statuses[indexPath.row];
    SCUser *user = status.user;
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    
    NSURL *url = [NSURL URLWithString:user.profile_image_url];
    UIImage *placeholderImage = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholderImage];
    
    return cell;
}

@end
