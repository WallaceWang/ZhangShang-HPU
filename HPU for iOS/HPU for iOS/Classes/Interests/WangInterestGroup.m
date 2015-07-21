//
//  WangInterestGroup.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/15.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "WangInterestGroup.h"
#import "InterestGroup.h"

@implementation WangInterestGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
   
        self.intesrstGroup = [InterestGroup interestGroupsWithArray:dict[@"group"]];
    }
    return self;
}

+ (instancetype)wangInterestGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)wangInterestGroups
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Interests.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self wangInterestGroupWithDict:dict]];
    }
    return arrayM;
}

@end
