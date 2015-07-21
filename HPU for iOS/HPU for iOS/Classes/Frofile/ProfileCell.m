//
//  ProfileCell.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/12.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (void)awakeFromNib {
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.profileCell.bounds) - 1.0, self.profileCell.width - 20, 1.0)];
    line.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [self.profileCell addSubview:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
