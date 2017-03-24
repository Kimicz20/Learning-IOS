//
//  Friend.h
//  QQConact
//
//  Created by Geek on 16/5/19.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,assign,getter=isVip) BOOL vip;

+(instancetype)friendWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
