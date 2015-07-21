//
//  LeftViewController.m
//  WXRSideViewController
//
//  Created by 王晓睿 on 15/7/13.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "LeftViewController.h"

#define xiaoyouhuiURL @"http://www.hpu.edu.cn"
#define zhaoshengjiuyeURL @"http://ao.hpu.edu.cn/jwc/index.jsp"
#define guanlijigouURL @"http://tieba.baidu.com/f?kw=%BA%D3%C4%CF%C0%ED%B9%A4%B4%F3%D1%A7&fr=ala0&loc=rec"
#define shuzihuaxiaoyuanURL @"http://218.196.240.25/dsl/"
#define guanfangweiboURL @"http://weibo.com/hpu1909"
#define xiaozhangxinxiangURL @"http://www.hpuxyh.com"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *schoolBadge;
@end

@implementation LeftViewController

-(UIImageView *)schoolBadge
{
    if (_schoolBadge == nil) {
        _schoolBadge = [[UIImageView alloc]initWithFrame:CGRectMake(50, 200, 80, 80)];
        [_schoolBadge setImage:[UIImage imageNamed:@"schoolBadge"]];
        _schoolBadge.layer.masksToBounds = YES;
        _schoolBadge.layer.cornerRadius = 40;
    }
    return _schoolBadge;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 280, 200, self.view.height - 250) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _tableView;
}

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        [_imageView setImage:[UIImage imageNamed:@"img_05"]];
        _imageView.alpha = 0.7;
    }
    return _imageView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.schoolBadge];
    [self.view addSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"--->>>leftView will appear");
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"--->>>leftView did appear");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"--->>>leftView will disappear");
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"--->>>leftView did disappear");
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    NSLog(@"left view rotate");
}
#pragma mark - tableView data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"学校首页";
            break;
        case 1:
            cell.textLabel.text = @"教务处";
            break;
        case 2:
            cell.textLabel.text = @"河南理工大学吧";
            break;
        case 3:
            cell.textLabel.text = @"数字化校园";
            break;
        case 4:
            cell.textLabel.text = @"官方微博";
            break;
        case 5:
            cell.textLabel.text = @"校长信箱";
            break;
        default:
            break;
    }
    
    return cell;

}
#pragma mark - tableView delegate
//-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return NO;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushViewController *vc = [[PushViewController alloc]init];
   
    [self presentViewController:vc animated:YES completion:nil];

    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    
    NSMutableDictionary *dictLeft = [NSMutableDictionary dictionary];
    dictLeft[NSForegroundColorAttributeName] = [UIColor whiteColor];

    [leftButton setTitleTextAttributes:dictLeft forState:UIControlStateNormal];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [vc.webViewBar setTitleTextAttributes:dict];
    //设置导航栏内容
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [vc.webViewBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    
    NSString *str;
    switch (indexPath.row) {
        case 0:
            str = xiaoyouhuiURL;
            [navigationItem setTitle:@"学校首页"];
            break;
        case 1:
            str = zhaoshengjiuyeURL;
            [navigationItem setTitle:@"教务处"];
            break;
        case 2:
            str = guanlijigouURL;
            [navigationItem setTitle:@"河南理工大学吧"];
            break;
        case 3:
            str = shuzihuaxiaoyuanURL;
            [navigationItem setTitle:@"数字化校园"];
            break;
        case 4:
            str = guanfangweiboURL;
            [navigationItem setTitle:@"官方微博"];
            break;
        case 5:
            str = xiaozhangxinxiangURL;
            [navigationItem setTitle:@"校长信箱"];
            break;

        default:
            break;
    }
    NSURL* url = [NSURL URLWithString:str];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [vc.webView loadRequest:request];//加载
}
-(void)clickLeftButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
