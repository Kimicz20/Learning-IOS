//
//  Message.m
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "Message.h"

@implementation Message

+(instancetype)messageWithDict:(NSDictionary *)dict{
    return  [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
