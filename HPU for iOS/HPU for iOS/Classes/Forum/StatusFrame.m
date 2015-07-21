//
//  StatusFrame.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

// cell的边框宽度
#define StatusCellBorderW 10

@implementation StatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setStatus:(Status *)status
{
    _status = status;
    
    User *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = StatusCellBorderW;
    CGFloat iconY = StatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);

    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + StatusCellBorderW;
    CGFloat nameY = iconY + 5;
    CGSize nameSize = [self sizeWithText:user.name font:StatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
//    /** 会员图标 */
//    if (user.isVip) {
//        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW;
//        CGFloat vipY = nameY;
//        CGFloat vipH = nameSize.height;
//        CGFloat vipW = 14;
//        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
//    }
    
//    /** 时间 */
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellBorderW;
//    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
//    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
//    
//    /** 来源 */
//    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [self sizeWithText:status.source font:HWStatusCellSourceFont];
//    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + StatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:StatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    CGFloat originalH = CGRectGetMaxY(self.contentLabelF) + StatusCellBorderW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    self.cellHeight = CGRectGetMaxY(self.originalViewF);
}
@end
