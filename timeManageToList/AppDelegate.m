//
//  AppDelegate.m
//  timeManageToList
//
//  Created by mac on 2017/8/29.
//  Copyright © 2017年 com.xz.timeManageToList. All rights reserved.
//

#import "AppDelegate.h"
#import <notify.h>
#import "IQKeyboardManager.h"
#import "TaskViewController.h"
#import "LoginViewController.h"

#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")

#define NotificationChange CFSTR("com.apple.springboard.lockstate")

#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")


@interface AppDelegate ()
{
}

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, assign) NSTimer *timer;

@property (nonatomic, assign)BOOL stateChanged;
@end


@implementation AppDelegate

//定义AppDelegate单例
+ (AppDelegate *)sharedDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///设置状态栏为白色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    ///监听是否app被强制退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:@"UIApplicationDidEnterBackgroundNotification" object:nil];
    NSLog(@"-----加载程序----------");
    // Override point for customization after application launch.
    //------------监测是否锁屏----------------
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationChange, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                    NULL, // observer
                                    displayStatusChanged, // callback
                                    CFSTR("com.apple.iokit.hid.displayStatus"), // event name
                                    NULL, // object
                                CFNotificationSuspensionBehaviorDeliverImmediately);
    //--------------------------------------
    //- 判断是否存在，强制登录
    if ([userModel getInstance].userId) {
        // 跳转到任务页面
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //登录界面
        TaskViewController *root = [[TaskViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:root];
        self.window.rootViewController = nav;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
        
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //登录界面
        LoginViewController *root = [[LoginViewController alloc]init];
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:root];
        self.window.rootViewController = nav;
        self.window.backgroundColor = [UIColor whiteColor];
        [self.window makeKeyAndVisible];
    }
    //--------------------------------------

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"即将被挂起");
    NSLog(@"系统状态%ld",(long)application.applicationState);
    NSLog(@"状态是%ld",(long)application.backgroundRefreshStatus);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [ self comeToBackgroundMode];
    NSLog(@"已经进入后台");
    NSLog(@"系统状态%ld",(long)application.applicationState);
    NSLog(@"状态是%ld",(long)application.backgroundRefreshStatus);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"即将进入前台");
    NSLog(@"系统状态%ld",(long)application.applicationState);
    NSLog(@"状态是%ld",(long)application.backgroundRefreshStatus);
    NSLog(@"%s",__FUNCTION__);

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"应用在准备进入前台运行时执行的函数（当应用从启动到前台，或从后台转入前台都会调用此方法)");
    NSLog(@"系统状态%ld",(long)application.applicationState);
    NSLog(@"状态是%ld",(long)application.backgroundRefreshStatus);

}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序被杀死");

}


-(void)comeToBackgroundMode{
    //初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前app在后台有任务处理，需要时间
    UIApplication*  app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:self.bgTask];
        self.bgTask = UIBackgroundTaskInvalid;
    }];
    //开启定时器 不断向系统请求后台任务执行的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:25.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
    [self.timer fire];
}


-(void)applyForMoreTime {
    //如果系统给的剩余时间小于60秒 就终止当前的后台任务，再重新初始化一个后台任务，重新让系统分配时间，这样一直循环下去，保持APP在后台一直处于active状态。
    NSLog(@"剩余时间:%f",[UIApplication sharedApplication].backgroundTimeRemaining );

    if ([UIApplication sharedApplication].backgroundTimeRemaining < 60) {
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
            self.bgTask = UIBackgroundTaskInvalid;
        }];
    }
}

-(void)judgeIndex{
    /*
     直接关闭屏幕状态，继续计时
     -[AppDelegate applicationWillResignActive:]
     -[AppDelegate applicationDidEnterBackground:]
     */
    /*
     切换别的应用
     applicationWillResignActive
     applicationDidEnterBackground

     */

    /*
     再次恢复APP
     -[AppDelegate applicationWillEnterForeground:]
     -[AppDelegate applicationDidBecomeActive:]
     */


}


static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)
{
    NSString* lockstate = (__bridge NSString*)name;
    /*
        这个问题是一个全面的特殊，
     */
    if ([lockstate isEqualToString:(__bridge  NSString*)NotificationLock]) {
        [AppDelegate sharedDelegate].stateChanged = YES;
        NSLog(@"锁屏");
    }
    else{
        if ([AppDelegate sharedDelegate].stateChanged) {
            [AppDelegate sharedDelegate].stateChanged = NO;
        }else{
            NSLog(@"解锁");
        }
    }



//    NSString* lockstate = (__bridge NSString*)name;
//    if ([lockstate isEqualToString:(__bridge  NSString*)NotificationLock]) {
//
//        NSLog(@"locked.");
//
//    } else if([lockstate isEqualToString:(__bridge  NSString*)NotificationChange]){
//
//        NSLog(@"lock state changed.");
//        
//    }
//    else{
//        NSLog(@"hasBlankedScreen.");
//
//    }

}

static void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    NSLog(@"event received!");
    // you might try inspecting the `userInfo` dictionary, to see
    //  if it contains any useful info
    if (userInfo != nil) {
        CFShow(userInfo);
    }
}



@end
