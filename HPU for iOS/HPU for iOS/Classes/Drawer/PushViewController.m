//
//  PushViewController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/13.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
        _webView.scalesPageToFit = YES;
        
    }
    return _webView;
}

-(UINavigationBar *)webViewBar
{
    if (_webViewBar == nil) {
        _webViewBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
        _webViewBar.barTintColor = [UIColor colorWithRed:145/255.0 green:0 blue:4/255.0 alpha:1.0];
    
    }
    return _webViewBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webViewBar];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
