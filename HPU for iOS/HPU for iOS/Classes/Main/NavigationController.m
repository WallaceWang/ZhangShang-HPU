//
//  NavigationController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/9.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:145/255.0 green:0 blue:2/255.0 alpha:1.0];
}

//-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:animated];
//    
//    if (self.viewControllers.count > 1) {
//        
//         viewController.hidesBottomBarWhenPushed = YES;
//    }
//   
//}


@end
