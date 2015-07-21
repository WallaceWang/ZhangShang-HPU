//
//  Groups.m
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/11.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import "Groups.h"

@implementation Groups

-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)groupsWithArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self groupWithDict:dict]];
    }
    
    return arrayM;

}

@end
