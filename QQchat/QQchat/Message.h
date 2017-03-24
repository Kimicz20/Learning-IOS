//
//  Message.h
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeMe = 0,//自己发的
    MessageTypeOther=1  //别人发的
} MessageType;

@interface Message : NSObject

//聊天内容
@property (nonatomic,copy) NSString *text;
//发送时间
@property (nonatomic,copy) NSString *time;
//是否自己发送
@property (nonatomic,assign) MessageType type;
//是否时间一致
@property (nonatomic,assign) BOOL ISSame;

+(instancetype)messageWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
