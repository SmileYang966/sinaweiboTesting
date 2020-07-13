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
#import "MJRefresh.h"
#import "SCHomeTableViewCell.h"
#import "SCStatusFrame.h"

@interface HomeViewController ()<SCDropdownMenuDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton *titleViewButton;
@property(nonatomic,strong)AccountModel *accountModel;
@property(nonatomic,strong)UITableView *tableView;

//TableView datasource
@property(nonatomic,strong)NSMutableArray *statusFrameArrayM;
@end


@implementation HomeViewController

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 64.0f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)statusFrameArrayM{
    if (_statusFrameArrayM == nil) {
        _statusFrameArrayM = [NSMutableArray array];
    }
    return _statusFrameArrayM;
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
    
    //4.添加下拉刷新控件
    [self addRefreshControl];
    
    //5.添加上拉刷新控件
    [self pullUpRefresh];
    
    //7.设置未读消息数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self setupUnreadCount];
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark 1.设置导航栏相关
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
    
}

#pragma mark 2.设置用户信息相关
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

#pragma mark 3.请求微博数据
-(void)loadData{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.accountModel.access_token forKey:@"access_token"];
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"statuses"];
        NSLog(@"array is %@",array);
        for (NSDictionary *dict in array) {
            SCStatusFrame *statusF = [[SCStatusFrame alloc]init];
            SCStatus *status = [SCStatus objectWithKeyValues:dict];
            statusF.status = status;
            [self.statusFrameArrayM addObject:statusF];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        int a = 10;
    }];
}

#pragma mark - 4.上拉刷新
//上拉刷新
-(void)pullUpRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    [self loadPullUpRefreshData];
    }];
}

//上拉刷新更多数据
-(void)loadPullUpRefreshData{
    __weak typeof(self) weakself = self;
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //1.取出最后一条微博数据
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    SCStatusFrame *lastStatusF = [self.statusFrameArrayM lastObject];
    SCStatus *lastStatus = lastStatusF.status;
    
    //2.设定max_id
    if (lastStatus) {
        long long lastStatusId = [lastStatus.idstr longLongValue];
        NSString *maxIdStr = [NSString stringWithFormat:@"%lld",lastStatusId-1];
        [params setValue:maxIdStr forKey:@"max_id"];
    }
    
    //3.设定access_token
    [params setValue:self.accountModel.access_token forKey:@"access_token"];
    
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *statusesArrayM = [NSMutableArray array];
        NSArray *statusArray = responseObject[@"statuses"];
        for (NSDictionary *dict in statusArray) {
            SCStatusFrame *statusF = [[SCStatusFrame alloc]init];
            SCStatus *status = [SCStatus objectWithKeyValues:dict];
            statusF.status = status;
            [statusesArrayM addObject:statusF];
        }
        
        [weakself.statusFrameArrayM addObjectsFromArray:statusesArrayM];
        [weakself.tableView reloadData];
        
        [weakself.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark 5.下拉刷新
-(void)addRefreshControl{
    //1.添加下拉刷新
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.开始刷新
    [control beginRefreshing];
    
    //3.立即刷新
    [self refreshValueChanged:control];
}

-(void)refreshValueChanged:(UIRefreshControl *)control{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //取出第一条微博数据的sinceId
    SCStatusFrame *firstStatusF = [self.statusFrameArrayM firstObject];
    if (firstStatusF != nil) {
        [params setValue:firstStatusF.status.idstr forKey:@"since_id"];
    }
    [params setValue:self.accountModel.access_token forKey:@"access_token"];
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"statuses"];
        NSMutableArray *newestStatuses = [NSMutableArray array];
        NSLog(@"array is %@",array);
        for (NSDictionary *dict in array) {
            SCStatusFrame *statusF = [[SCStatusFrame alloc]init];
            SCStatus *status = [SCStatus objectWithKeyValues:dict];
            statusF.status = status;
            [newestStatuses addObject:statusF];
        }
        
        //将最新获取到的数据加载到微博最前面
        NSRange range = NSMakeRange(0,newestStatuses.count);
        NSIndexSet *set = [[NSIndexSet alloc]initWithIndexesInRange:range];
        [self.statusFrameArrayM insertObjects:newestStatuses atIndexes:set];
        
        [self.tableView reloadData];
        
        //停止刷新数据
        [control endRefreshing];
        
        //有一个UILabel显示刷新数据的个数
        [self updatedRefreshStatusCount:array.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //停止刷新数据
        [control endRefreshing];
    }];
}

//刷新成功
-(void)updatedRefreshStatusCount:(NSInteger)count{
    
    //刷新成功后清0操作
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.y = 64-label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    if (count == 0) {//没有相关数据更新
        label.text = @"没有新的微博数据";
    }else{//更新了count个数据
        label.text = [NSString stringWithFormat:@"更新了%ld条数据",count];
    }
    
    [UIView animateWithDuration:1.0f animations:^{
        label.transform = CGAffineTransformMakeTranslation(0,label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f delay:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


#pragma mark 设置未读用户数
-(void)setupUnreadCount{
    //1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //2.拼接请求参数
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    AccountModel *account = [SCAccountTool  fetchAccount];
    parms[@"access_token"]=account.access_token;
    parms[@"uid"]=account.uid;
    
    //3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parms headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SCLog(@"responseObjec=%@",responseObject);
        
        int unreadCount = [responseObject[@"status"] intValue];
        if (unreadCount == 0) {//不限时微博数为0的情况
            self.tabBarItem.badgeValue = nil;
        }else{
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",unreadCount];
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


#pragma mark Event clicked
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
    return self.statusFrameArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCStatusFrame *statusF = self.statusFrameArrayM[indexPath.row];
    return statusF.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SCHomeTableViewCell *cell = [SCHomeTableViewCell cellwithTableView:tableView];
    SCStatusFrame *statusF = self.statusFrameArrayM[indexPath.row];
    cell.statusFrame = statusF;
    return cell;
}

@end
