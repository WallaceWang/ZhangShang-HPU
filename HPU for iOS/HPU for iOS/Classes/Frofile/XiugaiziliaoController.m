//
//  XiugaiziliaoController.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/20.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "XiugaiziliaoController.h"

@interface XiugaiziliaoController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) UITextField *shengriField;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIPickerView *yxPickeView;
@property (nonatomic,strong) UIPickerView *xbPickeView;
@end

@implementation XiugaiziliaoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
    
    UILabel *nicheng = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 40, 35)];
    nicheng.text = @"昵称";
    [self.view addSubview:nicheng];
    
    UILabel *yuanxi = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 40, 35)];
    yuanxi.text = @"院系";
    [self.view addSubview:yuanxi];
    
    UILabel *xingbie = [[UILabel alloc]initWithFrame:CGRectMake(20, 220, 40, 35)];
    xingbie.text = @"性别";
    [self.view addSubview:xingbie];
    
    UILabel *shengri = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, 40, 35)];
    shengri.text = @"生日";
    [self.view addSubview:shengri];
    
    
    UITextField *nichenField = [[UITextField alloc]initWithFrame:CGRectMake(nicheng.x + 60, nicheng.y, 250, 35)];
    nichenField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nichenField];

    UITextField *yuanxiField = [[UITextField alloc]initWithFrame:CGRectMake(yuanxi.x + 60, yuanxi.y, 250, 35)];
    yuanxiField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yuanxiField];
    

    UITextField *xingbieField = [[UITextField alloc]initWithFrame:CGRectMake(xingbie.x + 60, xingbie.y, 250, 35)];
    xingbieField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:xingbieField];
    

    UITextField *shengriField = [[UITextField alloc]initWithFrame:CGRectMake(shengri.x + 60, shengri.y, 250, 35)];
    shengriField.backgroundColor = [UIColor whiteColor];
    self.shengriField = shengriField;
    [self.view addSubview:shengriField];
    

    
    //代码创建UIDatePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    self.datePicker = datePicker;
    //设置datepicker的本地化
    NSArray *idents = [NSLocale availableLocaleIdentifiers];
    //设置datepicker的本地化为中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置datepicker模式
    datePicker.datePickerMode = UIDatePickerModeDate;//只显示日期，不显示时间
    //设置textFiled键盘
     shengriField.inputView = datePicker;
    
    //代码创建UIToolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
#warning 一定要设置bounds 否则UIBarButtonItem监听不了点击事件
    toolbar.bounds = CGRectMake(0, 0, 320, 44);
    toolbar.backgroundColor = [UIColor grayColor];
    
    //创建上一个按钮
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:nil action:nil];

    
    
    //弹簧
    UIBarButtonItem *tanhuangBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //创建完成按钮
    UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelectedDate)];
    
    
    
    //[toolbar setItems:<#(NSArray *)#>]
    toolbar.items = @[previous,tanhuangBtn,finish];
    
    //设置inputAccessoryView在，就能在键盘上面添加辅助的view
    shengriField.inputAccessoryView = toolbar;
   
    self.yxPickeView.delegate = self;
    self.yxPickeView.dataSource = self;
    
   UIPickerView *yxPickeView = [[UIPickerView alloc]init];
    self.yxPickeView = yxPickeView;
    xingbieField.inputView = self.yxPickeView;
    xingbieField.inputAccessoryView = toolbar;
    
    

}

-(void)finishSelectedDate{
    //获取时间
    NSDate *selectedDate = self.datePicker.date;
    
    //格式化日期(2014-08-25)
    //格式化日期类
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    
    //设置日期格式
    formater.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [formater stringFromDate:selectedDate];
    NSLog(@"%@",dateStr);
    
    //设置textfiled的文本
    
    self.shengriField.text = dateStr;
    
    //隐藏键盘
    [self.shengriField resignFirstResponder];
}
#pragma mark - UIPickeView datasource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

#pragma mark - UIPickeView delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        if (row == 0) {
        return @"男";
    }else{
        return @"女";
    }

    }
}
@end
