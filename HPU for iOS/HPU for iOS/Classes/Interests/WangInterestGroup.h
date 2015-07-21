//
//  WangInterestGroup.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/15.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WangInterestGroup : NSObject
@property (nonatomic,strong) NSArray *intesrstGroup;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)wangInterestGroupWithDict:(NSDictionary *)dict;

+ (NSArray *)wangInterestGroups;

@end
