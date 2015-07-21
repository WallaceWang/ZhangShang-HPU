//
//  InterestGroup.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/12.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestGroup : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)interestGroupWithDict:(NSDictionary *)dict;

+(NSArray *)interestGroupsWithArray:(NSArray *)array;
@end
