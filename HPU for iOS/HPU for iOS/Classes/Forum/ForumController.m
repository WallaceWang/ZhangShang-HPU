//
//  ForumController.m
//  HPU for iOS
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

//created_at	string	微博创建时间
//idstr	string	字符串型的微博ID
//text	string	微博信息内容
//source	string	微博来源
#import "ForumController.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "LoadMoreFooter.h"
#import "StatusCell.h"
#import "StatusFrame.h"

@interface ForumController ()
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation ForumController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载微博数据
//    [self loadNewStatus];
    // 集成下拉刷新控件
    [self setupDownRefresh];
    // 集成上拉刷新控件
    [self setupUpRefresh];
}
-(void)setupUpRefresh
{
    LoadMoreFooter *footer = [LoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}


-(void)setupDownRefresh
{
    UIRefreshControl *freshControl = [[UIRefreshControl alloc]init];
    [freshControl addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:freshControl];
    
    [freshControl beginRefreshing];
    
    [self loadNewStatus:freshControl];
}
/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (Status *status in statuses) {
        StatusFrame *f = [[StatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

-(void)loadNewStatus:(UIRefreshControl *)freshControl
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    Account *account = [AccountTool account];
    params[@"access_token"] = account.access_token;
    
    if (self.statusFrames.count) {
        // 取出最前面的微博
    StatusFrame *firstStatusF = [self.statusFrames firstObject];
    params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 微博字典数组转为微博模型数组
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *newStatus = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Status *status = [Status statusWithDict:dict];
            
            [newStatus addObject:status];
        }
        // 将 Status数组 转为 StatusFrame数组
         NSArray *newFrames = [self stausFramesWithStatuses:newStatus];
        // 将最新的微博数据添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        [self.tableView reloadData];
        
        [freshControl endRefreshing];
        [self showNewStatusCount:newStatus];
        //        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [freshControl endRefreshing];
    }];
    
}
/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    Account *account = [AccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    StatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *moreStatus = [NSMutableArray array];
        
        for (NSDictionary *dict in dictArray) {
            Status *status = [Status statusWithDict:dict];
            
            [moreStatus addObject:status];
        }
        // 将 Status数组 转为 StatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:moreStatus];
        
               [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}


-(void)showNewStatusCount:(NSArray *)newStatus
{
    UILabel *countLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 64 - 35, self.view.width, 35)];
    countLable.backgroundColor = [UIColor colorWithRed:145/255.0 green:0 blue:2/255.0 alpha:0.8];
    countLable.textColor = [UIColor whiteColor];
    countLable.textAlignment = NSTextAlignmentCenter;
    if (newStatus.count == 0) {
        countLable.text = @"没有新的微博数据";
    }else{
        countLable.text = [NSString stringWithFormat:@"共有%lu条新的微博数据",(unsigned long)newStatus.count];
    }
    
    [self.navigationController.view insertSubview:countLable belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
//        countLable.y += countLable.height;
        countLable.transform = CGAffineTransformMakeTranslation(0, countLable.height);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationCurveLinear animations:^{
//            countLable.y -= countLable.height;
            countLable.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            [countLable removeFromSuperview];
        }];
    }];
    
    
}
//-(void)loadNewStatus
//{
//    
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    HWAccount *account = [HWAccountTool account];
//    params[@"access_token"] = account.access_token;
//    
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSArray *dictArray = responseObject[@"statuses"];
//        
//        for (NSDictionary *dict in dictArray) {
//            Status *status = [Status statusWithDict:dict];
//            
//            [self.statuses addObject:status];
//        }
//        
//        
//        //        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        
//    }];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.statusFrames.count;
}

#pragma mark - tableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得cell
    StatusCell *cell = [StatusCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}
@end


