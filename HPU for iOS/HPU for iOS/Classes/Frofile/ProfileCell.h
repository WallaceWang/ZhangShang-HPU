//
//  ProfileCell.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/12.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *profileCell;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end
