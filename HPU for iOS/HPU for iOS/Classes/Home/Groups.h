//
//  Groups.h
//  HPU for iOS
//
//  Created by 王晓睿 on 15/7/11.
//  Copyright (c) 2015年 王晓睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Groups : NSObject
@property (nonatomic,copy) NSString *title;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)groupWithDict:(NSDictionary *)dict;

+(NSArray *)groupsWithArray:(NSArray *)array;
@end
