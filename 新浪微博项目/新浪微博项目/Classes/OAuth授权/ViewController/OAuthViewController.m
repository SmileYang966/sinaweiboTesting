//
//  oAuthViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/6.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "AccountModel.h"
#import "SCTabBarViewController.h"
#import "NewFeaturesViewController.h"

@interface OAuthViewController ()

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.用webView加载登录页面（新浪提供的）
    // 请求地址：https://api.weibo.com/oauth2/authorize
    /* 请求参数：
     client_id    true    string    申请应用时分配的AppKey。
     redirect_uri    true    string    授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    */
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3190008900&redirect_uri=http://"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    SCLog(@"webViewDidFinishLoad");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    SCLog(@"webViewDidStartLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
    }
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSDictionary *params = @{
        @"code" : code,
        @"redirect_uri" : @"http://",
        @"client_id" : @"3190008900",
        @"client_secret" : @"2cd9693597a594dc1b8aeee8ca2f7c0a",
        @"grant_type" : @"authorization_code"
    };
    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
       NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [docDirPath stringByAppendingPathComponent:@"account.archive"];
        NSLog(@"filePath is %@",filePath);
        
        AccountModel *accountModel = [AccountModel accountWithDict:responseObject];
        [NSKeyedArchiver archiveRootObject:accountModel toFile:filePath];
        
        //获取上一次存储的版本号
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        //获取当前存储的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        
        //版本号相同，不进入新特性界面
        if ([currentVersion isEqualToString:lastVersion]) {
            SCTabBarViewController *tabBarVC = [[SCTabBarViewController alloc]init];
            [UIApplication sharedApplication].windows.firstObject.rootViewController = tabBarVC;
        }else{
            NewFeaturesViewController *newFeatureController = [[NewFeaturesViewController alloc]init];
            [UIApplication sharedApplication].windows.firstObject.rootViewController = newFeatureController;
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

@end
