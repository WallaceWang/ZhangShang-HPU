//
//  StatusFrame.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define StatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define StatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define StatusCellSourceFont StatusCellTimeFont
// 正文字体
#define StatusCellContentFont [UIFont systemFontOfSize:14]


@class Status;

@interface StatusFrame : NSObject
@property (nonatomic, strong) Status *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
