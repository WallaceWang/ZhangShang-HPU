//
//  UIBarButtonItem+Extension.m
//  WangWeiBo
//
//  Created by 王晓睿 on 15/7/7.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  方法描述
 *
 *  @param target        说明了调用了谁的方法
 *  @param normalImage   图片默认状态
 *  @param selectedImage 图片选中状态
 *  @param action        说明了调用了哪个方法
 *
 *  @return UIBarButtonItem对象
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target NormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage action:(SEL)action
{
    // 设置样式
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];;
    
}

@end
