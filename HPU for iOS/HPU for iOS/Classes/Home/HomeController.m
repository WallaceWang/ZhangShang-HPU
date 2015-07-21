//
//  HomeController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/9.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//
#define kImageNumber 5
#define scrollViewX 0
#define scrollViewY CGRectGetMaxY(self.navigationController.navigationBar.frame)
#define scrollViewWidth [UIScreen mainScreen].bounds.size.width
#define scrollViewHeight 162.5

#define xuexiaojianjieURL @"http://www.hpu.edu.cn/www/channels/xxjj.html"
#define xuexiaozhangchengURL @"http://www.hpu.edu.cn/www/channels/zhc.html"
#define lishiyangeURL @"http://www.hpu.edu.cn/www/channels/lsyg.html"
#define xianrenlingdaoURL @"http://www.hpu.edu.cn/www/channels/xrld.html"
#define lirenlingdaoURL @"http://www.hpu.edu.cn/www/channels/lrld.html"
#define anquanURL @"http://173.jzrongda.com/safe/"
#define nengyuanURL @"http://sese.hpu.edu.cn/web2014/index.php"
#define ziyuanURL @"http://rei.hpu.edu.cn"
#define jixieURL @"http://smpe.hpu.edu.cn"
#define jingjiURL @"http://jgxy.hpu.edu.cn"
#define tumuURL @"http://civil.hpu.edu.cn"
#define cailiaoURL @"http://mse.hpu.edu.cn/hpucl/"
#define dianqiURL @"http://seea.hpu.edu.cn/www/index.aspx"
#define cehuiURL @"http://sslie.hpu.edu.cn"
#define jisuanjiURL @"http://cst.hpu.edu.cn"
#define makesiURL @"http://218.196.240.143"
#define waiguoyuURL @"http://sfs.hpu.edu.cn"
#define zhaoshengURL @"http://zhaosheng.hpu.edu.cn"
#define chengpinURL @"http://www.hpu.edu.cn/www/channels/5683.html"


#import "HomeController.h"
#import "DrawerView.h"
#import "WangGroups.h"
#import "Groups.h"
#import "PushViewController.h"
#import "AppDelegate.h"
#import "SideViewController.h"

@interface HomeController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) DrawerView *drawer;
@property (nonatomic,assign) BOOL isCoverHit;
@property (nonatomic,weak) UIView *cover;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation HomeController

-(NSArray *)groups
{
    if (_groups == nil) {
        _groups = [WangGroups wangGroups];
    }
    return _groups;
}

// 抽屉
-(DrawerView *)drawer
{
    if (_drawer == nil) {
        
        _drawer = [[DrawerView alloc]init];
        _drawer.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width * 0.6, 0, [UIScreen mainScreen].bounds.size.width * 0.6, [UIScreen mainScreen].bounds.size.height);
        _drawer.backgroundColor = [UIColor colorWithRed:145/255.0 green:0 blue:2/255.0 alpha:1.0];
        
    }
    return _drawer;
}
// 主页上方滚动视图
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64,scrollViewWidth, scrollViewHeight)];
        _scrollView.backgroundColor = [UIColor redColor];
        
        // 滚动视图大小
        _scrollView.contentSize = CGSizeMake(kImageNumber * _scrollView.width, 0);
        _scrollView.pagingEnabled = YES;// 分页
        // 不显示滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;// 关闭弹簧效果
        
        _scrollView.delegate = self;
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
// 滚动视图的小点点
-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = kImageNumber;
        
        // 告诉页数，会自动算出pageControl的大小
        _pageControl.size = [_pageControl sizeForNumberOfPages:kImageNumber];
        // 设置位置
        _pageControl.centerX = [UIScreen mainScreen].bounds.size.width / 2;
        _pageControl.centerY = 220 - 64;
        // 未显示的页面的点点的颜色
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        // 当前显示页面点点的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        // 添加监听方法，监听事件 值改变
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

- (void)changePage:(UIPageControl *)pageControl
{
    // 获取改变量
    CGFloat value = pageControl.currentPage * self.scrollView.width;
    // 把改变量设置为ContentOffset,从而改变当前页数
    [self.scrollView setContentOffset:CGPointMake(value, 0) animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = self.scrollView;
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self NormalImage:@"navigationbar_friendsearch" selectedImage:@"navigationbar_friendsearch_highlighted" action:@selector(more)];
//    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self NormalImage:@"navigationbar_pop" selectedImage:@"navigationbar_pop_highlighted" action:@selector(setting)];
    
    /**
     *  添加滚动视图
     */
    for (int i = 0; i < kImageNumber; ++i) {
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,scrollViewWidth, scrollViewHeight)];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    /**
     *  展示scrollView的视图
     *
     *  @param imageView 视图
     *  @param idx       索引
     *  @param stop      <#stop description#>
     *
     *  @return <#return value description#>
     */
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        CGRect frame = imageView.frame;
        frame.origin.x = frame.size.width *idx;
        imageView.frame = frame;
    }];

    [self.view addSubview:self.pageControl];
    
    [self startTimer];// 时钟
}

- (void)startTimer
{
//
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer
{
    int page = (self.pageControl.currentPage + 1) % kImageNumber;
    self.pageControl.currentPage = page;
    [self changePage:self.pageControl];
}

- (void)more
{
//    self.isCoverHit = NO;
//    UIView *cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    cover.backgroundColor = [UIColor clearColor];
//    self.cover = cover;
//    
//    [self.view.window addSubview:cover];
    
//// 添加手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
//    tap.numberOfTapsRequired = 1;
//    [cover addGestureRecognizer:tap];
//    [tap addTarget:self action:@selector(changeIsCoverHit)];
//    
//    [self.view.window addSubview:self.drawer];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.drawer.x += [UIScreen mainScreen].bounds.size.width * 0.6;
//    } completion:^(BOOL finished) {
//        
//    }];
//    AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    YRSideViewController *sideViewController=[delegate sideViewController];
//    [sideViewController showLeftViewController:true];
    
//        AppDelegate *delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        SideViewController *sideViewController=[SideViewController shareSideViewController];
        [sideViewController showLeftViewController:true];

}
- (void)changeIsCoverHit
{
    self.isCoverHit = YES;
    [self.cover removeFromSuperview];
   if (self.isCoverHit == YES) {
       // 收尾式动画
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
    
        // 重新设置bounds
        self.drawer.x -= [UIScreen mainScreen].bounds.size.width * 0.6;
    
        // 3> 提交动画
        [UIView commitAnimations];

    }
}

#pragma mark - scrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    NSLog(@"%d",self.groups.count);
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WangGroups *wangGroups = self.groups[section];
    return wangGroups.group.count;
}
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    
//    return [self.groups[section] header];
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    
    headerLabel.text = [self.groups[section] header];
    headerLabel.backgroundColor = [UIColor clearColor];

    headerLabel.font = [UIFont boldSystemFontOfSize:13.0];
    return headerLabel;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // 设置cell内容
    // 1、取出数据模型
    WangGroups *wangGroups = self.groups[indexPath.section];
    Groups *groups = wangGroups.group[indexPath.row];
    // 2、设置数据
    cell.textLabel.text = groups.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
//    cell.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;

}
#pragma  mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PushViewController *pushVC = [[PushViewController alloc]init];
//    [self.navigationController pushViewController:pushVC animated:YES];
    [self presentViewController:pushVC animated:YES completion:nil];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    
    //创建一个左边按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    
    NSMutableDictionary *dictLeft = [NSMutableDictionary dictionary];
    dictLeft[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [leftButton setTitleTextAttributes:dictLeft forState:UIControlStateNormal];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [pushVC.webViewBar setTitleTextAttributes:dict];

    // 设置导航栏内容在switch中
    
    //把导航栏集合添加入导航栏中，设置动画关闭
    [pushVC.webViewBar pushNavigationItem:navigationItem animated:NO];
    
    //把左右两个按钮添加入导航栏集合中
    [navigationItem setLeftBarButtonItem:leftButton];
    
    NSString *str;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                str = xuexiaojianjieURL;
               [navigationItem setTitle:@"学校简介"]; }
                break;
            case 1:{
                str = xuexiaozhangchengURL;

                [navigationItem setTitle:@"学校章程"];
            }
                break;
            case 2:{
                str = lishiyangeURL;

               [navigationItem setTitle:@"历史沿革"];
            }
                break;
            case 3:{
                str = xianrenlingdaoURL;

                [navigationItem setTitle:@"现任领导"];
            }
                break;
            case 4:{
                str = lirenlingdaoURL;

               [navigationItem setTitle:@"历任领导"];
            }
                break;
            
        default:
            break;
        }
    }else if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:{
                    str = anquanURL;
                    [navigationItem setTitle:@"安全学院"];
                }
                    break;
                case 1:{
                    str = nengyuanURL;
                    
                    [navigationItem setTitle:@"能源学院"];
                }
                    break;
                case 2:{
                    str = ziyuanURL;
                    
                    [navigationItem setTitle:@"资环学院"];
                }
                    break;
                case 3:{
                    str = jixieURL;
                    
                    [navigationItem setTitle:@"机械学院"];
                }
                    break;
                case 4:{
                    str = jingjiURL;
                    
                    [navigationItem setTitle:@"经管学院"];
                }
                    break;
                case 5:{
                    str = tumuURL;
                    
                    [navigationItem setTitle:@"土木学院"];
                }
                    break;
                case 6:{
                    str = cailiaoURL;
                    
                    [navigationItem setTitle:@"材料学院"];
                }
                    break;
                case 7:{
                    str = dianqiURL;
                    
                    [navigationItem setTitle:@"电气学院"];
                }
                    break;
                case 8:{
                    str = cehuiURL;
                    
                    [navigationItem setTitle:@"测绘学院"];
                }
                    break;
                case 9:{
                    str = jisuanjiURL;
                    
                    [navigationItem setTitle:@"计算机学院"];
                }
                    break;
                case 10:{
                    str = makesiURL;
                    
                    [navigationItem setTitle:@"马克思学院"];
                }
                    break;
                case 11:{
                    str = waiguoyuURL;
                    
                    [navigationItem setTitle:@"外国语学院"];
                }
                    break;
                default:
                    break;
            }
    } else {
                switch (indexPath.row) {
                    case 0:{
                        str = zhaoshengURL;
                        [navigationItem setTitle:@"招生就业"];
                    }
                        break;
                    case 1:{
                        str = chengpinURL;
                        
                        [navigationItem setTitle:@"诚聘英才"];
                    }
                        break;
                    default:
                        break;
                }
    }

        NSURL* url = [NSURL URLWithString:str];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
        [pushVC.webView loadRequest:request];//加载

    
}
-(void)clickLeftButton
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
