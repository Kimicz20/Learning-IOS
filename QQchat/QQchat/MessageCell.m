//
//  MessageCell.m
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"

@interface MessageCell()
    @property (nonatomic,weak) UILabel *timeView;
    @property (nonatomic,weak) UIImageView *iconView;
    @property (nonatomic,weak) UIButton *textView;
@end

@implementation MessageCell

+(instancetype)cellWithTableView:(UITableView *)tableview{
    //循环利用cell
    static NSString *ID = @"message";
    //1.去缓存池去cell
    MessageCell *msgCell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    //2.创建模型
    if(msgCell == nil){
        msgCell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return msgCell;
}

#pragma mark 初始化模型
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //子控件的创建和初始化
        //1.时间
        UILabel *timeView = [[UILabel alloc] init];
        timeView.textAlignment = NSTextAlignmentCenter;
        timeView.textColor = [UIColor grayColor];
        timeView.font = timeFont;
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        
        //2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //3.内容
        UIButton *textView = [[UIButton alloc] init];
        textView.titleLabel.numberOfLines=0;
        textView.titleLabel.font = textFont;
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置内部间距
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark 设置模型数据以及大小
-(void)setMessageF:(MessageFrame *)messageF{
    _messageF = messageF;
    
    //1.设置数据
    [self settingData];
    //2.设置格式
    [self setSubviewFrame];
}

#pragma mark 设置模型尺寸
-(void)setSubviewFrame{
    self.timeView.frame = self.messageF.timeF;
    self.iconView.frame = self.messageF.iconF;
    self.textView.frame = self.messageF.textF;
}

#pragma mark 设置模型数据
-(void)settingData{
    Message *msg = _messageF.message;
    
    //1.时间
    self.timeView.text = msg.time;
    [self.timeView setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]];
    //2.头像
    NSString *imgIcon = (msg.type == MessageTypeOther) ? @"other" : @"01.jpg";
    self.iconView.image = [UIImage imageNamed:imgIcon];
    
    //3.聊天内容
    [self.textView setTitle:msg.text forState:UIControlStateNormal];
    
    //4.聊天气泡设置
    
    NSString *imgNorText = (msg.type == MessageTypeOther) ? @"chat_recive_nor" : @"chat_send_nor";
    UIImage *normalImg =[UIImage imageNamed:imgNorText];
    //伸缩图片
    CGFloat w = normalImg.size.width *0.5;
    CGFloat h = normalImg.size.height *0.5;
    UIImage *lastNorImg = [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    [self.textView setBackgroundImage:lastNorImg forState:UIControlStateNormal];
    
    NSString *imgHighText = (msg.type == MessageTypeOther) ? @"chat_recive_press" : @"chat_send_press";
    UIImage *pressImg = [UIImage imageNamed:imgHighText];
    UIImage *lastPreImg = [pressImg resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    [self.textView setBackgroundImage:lastPreImg forState:UIControlStateHighlighted];
    
    
}
@end
