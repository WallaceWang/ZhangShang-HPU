//
//  ViewController.m
//  Athous
//
//  Created by 王晓睿 on 15/7/15.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//
//"access_token" = "2.00FqKvaCRUlpfD0f00d293800vYC8_";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 2377840125;
//params[@"client_id"] = @"3366565545";
//params[@"client_secret"] = @"fca6654ae016ca874df503cabd0b1e44";
//params[@"grant_type"] = @"authorization_code";
//params[@"redirect_uri"] = @"http://www.hpu.edu.cn";
//params[@"code"] = code;

#import "OAuthController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Account.h"
#import "AccountTool.h"
#import "SideViewController.h"

@interface OAuthController ()<UIWebViewDelegate>

@end

@implementation OAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3366565545&redirect_uri=http://www.hpu.edu.cn"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}
#pragma mark - webView delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"hah");
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        int fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        [self accessTokenWithCode:code];
    }
    return  YES;// 禁止回调地址
}

-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
//    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3366565545";
    params[@"client_secret"] = @"fca6654ae016ca874df503cabd0b1e44";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.hpu.edu.cn";
    params[@"code"] = code;

    
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        Account *account = [Account accountWithDict:responseObject];
        // 存储账号信息
        [AccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        [window switchRootViewController];
        window.rootViewController = [SideViewController shareSideViewController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败----%@",error);
    }];
}
@end
