//
//  WangGroups.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/11.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "WangGroups.h"
#import "Groups.h"

@implementation WangGroups

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValue:dict[@"header"] forKey:@"header"];
        self.group = [Groups groupsWithArray:dict[@"group"]];
    }
    return self;
}

+ (instancetype)wangGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)wangGroups
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HomeSeting.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self wangGroupWithDict:dict]];
    }
    return arrayM;
}

@end
