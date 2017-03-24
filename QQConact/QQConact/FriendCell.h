//
//  FriendCell.h
//  QQConact
//
//  Created by Geek on 16/5/23.
//  Copyright © 2016年 Geek. All rights reserved.
//

@class Friend;

@interface FriendCell : UITableViewCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) Friend *friendData;

@end
