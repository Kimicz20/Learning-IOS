//
//  MessageFrame.m
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

#pragma mark 设置消息尺寸
-(void)setMessage:(Message *)message{
    _message = message;

    //屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    //1.时间设置
    if(!message.ISSame){
        CGFloat timeX = kCellBorder;
        CGFloat timeY = kCellBorder;
        CGSize timeSize = [message.time sizeWithFont:timeFont];
        //CGSize timeSize = [self sizeWithText:message.time font:textFont maxSize:textMaxSize];
        _timeF = CGRectMake(timeX, timeY, screenW, timeSize.height);
    }
    //2.头像设置
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = 50;
    CGFloat iconH = 50;
    if(message.type == MessageTypeOther){
        iconX = kCellBorder;
    }else{
        iconX = screenW - kCellBorder - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //3.聊天内容
    CGFloat textY = iconY;
    
    //CGSize textSize = [self sizeWithText:message.text font:textFont maxSize:textMaxSize];
    //文字计算的最大尺寸
    CGSize textMaxSize = CGSizeMake(150, MAXFLOAT);
    //文字计算出来的实际尺寸（按钮内部label的尺寸）
    CGSize textRealSize = [message.text sizeWithFont:textFont constrainedToSize:textMaxSize];
    //按钮的最终尺寸
    CGSize textBtnSize = CGSizeMake(textRealSize.width + textPadding*2, textRealSize.height + textPadding*2);
    
    CGFloat textX;
    if(message.type == MessageTypeOther){
        textX = CGRectGetMaxX(_iconF)+kCellBorder;
    }else{
        textX =  iconX - kCellBorder - textBtnSize.width;
    }
    _textF = (CGRect){{textX,textY},textBtnSize};
    
    //4.frame高度
    _cellHeight = MAX(CGRectGetMaxY(_iconF), CGRectGetMaxY(_textF));
}

@end
