//
//  UIBarButtonItem+Extension.h
//  WangWeiBo
//
//  Created by 王晓睿 on 15/7/7.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem*)itemWithTarget:(id)target NormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage action:(SEL)action;
@end
