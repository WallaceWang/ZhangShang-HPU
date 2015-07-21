//
//  AppDelegate.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/15.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "AppDelegate.h"

#import "OAuthController.h"
#import "Account.h"
#import "AccountTool.h"
#import "SideViewController.h"
#import "SDWebImageManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 2.设置根控制器
    Account *account = [AccountTool account];
    
    if (account) {// 意味着之前登陆成功过
        
        self.window.rootViewController=[SideViewController shareSideViewController];
        
    }else{
        self.window.rootViewController = [[OAuthController alloc]init];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    // 1、取消下载
    [mgr cancelAll];
    // 2、清除图片
    [mgr.imageCache clearMemory];
}
@end
