//
//  Status.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/16.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "Status.h"
#import "User.h"

@implementation Status

+(instancetype)statusWithDict:(NSDictionary *)dict
{
    Status *status = [[self alloc]init];
    
    status.created_at = dict[@"created_at"];
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.source = dict[@"source"];
    status.user = [User userWithDict:dict[@"user"]];
                   
    return status;

}
                   
@end
