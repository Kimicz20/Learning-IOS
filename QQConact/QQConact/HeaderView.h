//
//  HeaderCell.h
//  QQConact
//
//  Created by Geek on 16/5/23.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendGroup,HeaderView;

@protocol HeaderViewDelegate <NSObject>
@optional
-(void)headerViewDidClickTitle:(HeaderView *)headerView;
@end

@interface HeaderView : UITableViewHeaderFooterView

+(instancetype)headerViewWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) FriendGroup *group;
@property (nonatomic,weak) id<HeaderViewDelegate> delegate;
@end
