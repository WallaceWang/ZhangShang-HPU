//
//  InterestsController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/9.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#define lvyouURL @"http://www.hnjzta.gov.cn"
#define meishiURL @"http://shop.bytravel.cn/produce/food/index436_list.html"
#define cet4URL @"http://cet4.koolearn.com"
#define cet6URL @"http://cet6.koolearn.com"
#define kaoyanURL @"http://yz.chsi.com.cn"
#define kaogongwuyuanURL @"http://www.offcn.com"
#define chuguoliuxueURL @"http://www.tigtag.com"
#define zhaopinURL @"http://www.58.com/job/"

#import "InterestsController.h"
#import "InterestGroup.h"
#import "WangInterestGroup.h"
#import "PushViewController.h"

@interface InterestsController ()
@property (nonatomic,strong) NSArray *array;
@end

@implementation InterestsController

-(NSArray *)array
{
    if (_array == nil) {
        _array = [WangInterestGroup wangInterestGroups];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView Data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WangInterestGroup *wangInterestGroup = self.array[section];
    return wangInterestGroup.intesrstGroup.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    // 设置cell内容
//    // 1、取出数据模型
//    WangGroups *wangGroups = self.groups[indexPath.section];
//    Groups *groups = wangGroups.group[indexPath.row];
//    // 2、设置数据
//    cell.textLabel.text = groups.title;
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
//    //    cell.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
//    cell.backgroundColor = [UIColor whiteColor];
    WangInterestGroup *wangInterestGroup = self.array[indexPath.section];
    InterestGroup *group = wangInterestGroup.intesrstGroup[indexPath.row];
    
    cell.textLabel.text = group.title;
//    cell.imageView
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}
#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor whiteColor];
//    vc.hidesBottomBarWhenPushed = YES;
//    WangInterestGroup *wangInterestGroup = self.array[indexPath.section];
//    vc.navigationItem.title = [wangInterestGroup.intesrstGroup[indexPath.row] title];
//    [self.navigationController pushViewController:vc animated:YES];
    
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
                str = lvyouURL;
                [navigationItem setTitle:@"旅游"]; }
                break;
            case 1:{
                str = meishiURL;
                
                [navigationItem setTitle:@"美食"];
            }
                break;
                        default:
                break;
        }
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                str = cet4URL;
                [navigationItem setTitle:@"CET4"];
            }
                break;
            case 1:{
                str = cet6URL;
                
                [navigationItem setTitle:@"CET6"];
            }
                break;
                        default:
                break;
        }
    }else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{
                str = kaoyanURL;
                [navigationItem setTitle:@"考研"];
            }
                break;
            case 1:{
                str = kaogongwuyuanURL;
                
                [navigationItem setTitle:@"考公务员"];
            }
                break;
            case 2:{
                str = chuguoliuxueURL;
                
                [navigationItem setTitle:@"出国留学"];
            }
                break;

            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0:{
                str = zhaopinURL;
                [navigationItem setTitle:@"招聘"];
            }
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
