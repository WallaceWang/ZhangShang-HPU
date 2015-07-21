//
//  TabBarController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/9.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "TabBarController.h"
#import "HomeController.h"
#import "ForumController.h"
#import "InterestsController.h"
#import "NavigationController.h"
#import "ViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabBar.barTintColor = [UIColor whiteColor];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] = [UIColor redColor];
//    
//    [self.tabBarItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
//    self.tabBar.backgroundColor = [UIColor redColor];
    HomeController *home = [[HomeController alloc]init];
    
    [self addChildVCWithController:home title:@"首页" image:@"wanghome" imageHigh:@"wanghome_selected"];
    
    InterestsController *interest = [[InterestsController alloc]init];
    [self addChildVCWithController:interest title:@"兴趣" image:@"wanginterest" imageHigh:@"wangintrerst_selected"];

    ForumController *forum = [[ForumController alloc]init];
    [self addChildVCWithController:forum title:@"社交" image:@"wangluntan" imageHigh:@"wangluntan_selected"];

    ViewController *frofile = [[ViewController alloc]init];
    [self addChildVCWithController:frofile title:@"我" image:@"wangfrofile" imageHigh:@"wangfrofile_selected"];

    
}
- (void)addChildVCWithController:(UIViewController *)VC title:(NSString *)titile image:(NSString *)image imageHigh:(NSString *)imageHigh
{

    VC.title = titile;
    VC.view.backgroundColor = [UIColor WangColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithRed:145/255.0 green:0 blue:4/255.0 alpha:1.0];
    [VC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    [VC.tabBarItem setImage:[UIImage imageNamed:image]];
    [VC.tabBarItem setSelectedImage:[[UIImage imageNamed:imageHigh]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    NavigationController *naVC = [[NavigationController alloc]initWithRootViewController:VC];
    
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    titleDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleDict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19.0];
    [naVC.navigationBar setTitleTextAttributes:titleDict];
    [self addChildViewController:naVC];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
