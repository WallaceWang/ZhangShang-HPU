//
//  WangGroups.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/11.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WangGroups : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic,strong) NSArray *group;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)wangGroupWithDict:(NSDictionary *)dict;

+ (NSArray *)wangGroups;

@end
