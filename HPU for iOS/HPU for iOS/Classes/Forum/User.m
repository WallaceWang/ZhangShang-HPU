//
//  User.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/17.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)userWithDict:(NSDictionary *)dict
{
    User *user = [[self alloc]init];
    
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}
@end
