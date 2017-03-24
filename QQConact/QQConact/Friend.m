//
//  Friend.m
//  QQConact
//
//  Created by Geek on 16/5/19.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "Friend.h"

@implementation Friend

+(instancetype)friendWithDict:(NSDictionary *)dict{
    return [[super alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
