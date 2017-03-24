//
//  FriendGroup.m
//  QQConact
//
//  Created by Geek on 16/5/19.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "FriendGroup.h"
#import "Friend.h"

@implementation FriendGroup

+(instancetype)gourpWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        //1.注入所有属性
        [self setValuesForKeysWithDictionary:dict];
        
        //2.处理特殊属性
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *d in self.friends) {
            Friend *fd = [Friend friendWithDict:d];
            [friendArray addObject:fd];
        }
        self.friends = friendArray;
    }
    return self;
}

@end
