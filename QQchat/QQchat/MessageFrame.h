//
//  MessageFrame.h
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kCellBorder 5
#define timeFont [UIFont systemFontOfSize:10]
#define textFont [UIFont systemFontOfSize:15]
#define textPadding 20
@class  Message;

@interface MessageFrame : NSObject

//时间frame
@property (nonatomic, assign, readonly) CGRect timeF;
//头像frame
@property (nonatomic, assign, readonly) CGRect iconF;
//正文frame
@property (nonatomic, assign, readonly) CGRect textF;
//frame高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic,strong) Message *message;
@end
