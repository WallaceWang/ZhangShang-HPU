//
//  SideViewController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/16.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "SideViewController.h"
#import "LeftViewController.h"
#import "TabBarController.h"

@interface SideViewController ()

@end

@implementation SideViewController

static SideViewController *shareSideViewController = nil;

+(SideViewController *)shareSideViewController
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareSideViewController = [[self alloc]init];
    });
    return shareSideViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TabBarController *mainViewController=[[TabBarController alloc]init];
 
    
    
    mainViewController.view.backgroundColor=[UIColor grayColor];
    
    LeftViewController *leftViewController=[[LeftViewController alloc]initWithNibName:nil bundle:nil];
    leftViewController.view.backgroundColor=[UIColor colorWithRed:145/255.0 green:0 blue:4/255.0 alpha:1.0];
    
    
    
    self.rootViewController=mainViewController;
    self.leftViewController=leftViewController;
    
    
    self.leftViewShowWidth=200;
    self.needSwipeShowMenu=true;//默认开启的可滑动展示
            //动画效果可以被自己自定义，具体请看api
    
}

@end
