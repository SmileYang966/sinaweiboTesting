#import "SceneDelegate.h"
#import "SCTabBarViewController.h"
#import "NewFeaturesViewController.h"
#import "OAuthViewController.h"
#import "AccountModel.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setWindowScene:(UIWindowScene *)scene];
    
    
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSString *filePath = [docDirPath stringByAppendingPathComponent:@"account.archive"];
    
    
    AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    
    if (account != nil) {//已经有账号了
        
        //获取上一次存储的版本号
        NSString *key = @"CFBundleVersion";
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        //获取当前存储的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        
        //版本号相同，不进入新特性界面
        if ([currentVersion isEqualToString:lastVersion]) {
            SCTabBarViewController *tabBarVC = [[SCTabBarViewController alloc]init];
            self.window.rootViewController = tabBarVC;
        }else{
            NewFeaturesViewController *newFeatureController = [[NewFeaturesViewController alloc]init];
            self.window.rootViewController = newFeatureController;
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }else{
        OAuthViewController *authVc = [[OAuthViewController alloc]init];
        self.window.rootViewController = authVc;
    }
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
