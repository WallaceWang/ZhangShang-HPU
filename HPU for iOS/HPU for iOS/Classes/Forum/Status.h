//
//  Status.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/16.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//
//created_at	string	微博创建时间
//idstr	string	字符串型的微博ID
//text	string	微博信息内容
//source	string	微博来源
#import <Foundation/Foundation.h>
@class User;
@interface Status : NSObject
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *idstr;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,strong) User *user;

+(instancetype)statusWithDict:(NSDictionary *)dict;

@end
