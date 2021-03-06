//
//  StatusCell.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;

@interface StatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) StatusFrame *statusFrame;
@end
