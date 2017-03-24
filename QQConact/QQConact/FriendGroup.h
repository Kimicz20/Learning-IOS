//
//  FriendGroup.h
//  QQConact
//
//  Created by Geek on 16/5/19.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Friend;

@interface FriendGroup : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int online;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic,assign,getter=isOpened) BOOL open;

+(instancetype)gourpWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
