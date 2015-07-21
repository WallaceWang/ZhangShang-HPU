//
//  InterestGroup.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/12.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "InterestGroup.h"

@implementation InterestGroup

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)interestGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)interestGroupsWithArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self interestGroupWithDict:dict]];
    }
    
    return arrayM;
    
}

@end
