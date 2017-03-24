//
//  MessageCell.h
//  QQchat
//
//  Created by Geek on 16/5/12.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageFrame;

@interface MessageCell : UITableViewCell

@property (nonatomic,strong)MessageFrame *messageF;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
