//
//  User.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//
//idstr	string	字符串型的用户UID

//name	string	友好显示名称

//profile_image_url	string	用户头像地址（中图），50×50像素

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image_url;
/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

+(instancetype)userWithDict:(NSDictionary *)dict;
@end
