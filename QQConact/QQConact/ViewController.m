//
//  ViewController.m
//  QQConact
//
//  Created by Geek on 16/5/19.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "ViewController.h"
#import "FriendGroup.h"
#import "Friend.h"
#import "FriendCell.h"
#import "HeaderView.h"


@interface ViewController ()<HeaderViewDelegate>
    @property (nonatomic,strong) NSArray *groups;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 每一行cell的高度
    self.tableView.rowHeight = 50;
    // 每一组头部控件的高度
    self.tableView.sectionHeaderHeight = 44;
}

#pragma mark 懒加载
-(NSArray *)groups{
    if(_groups == nil){
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
                NSMutableArray *gourpArray = [NSMutableArray array];
        for(NSDictionary *dict in dictArray){
            FriendGroup *fgoup = [FriendGroup gourpWithDict:dict];
            [gourpArray addObject:fgoup];
        }
        _groups = gourpArray;
    }
    return _groups;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FriendGroup *group = self.groups[section];
    return (group.isOpened ? group.friends.count : 0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.获取cell
    FriendCell *cell = [FriendCell friendCellWithTableView:tableView];
    //2.设置数据
    FriendGroup *group = self.groups[indexPath.section];
    Friend *fd = group.friends[indexPath.row];
    cell.friendData = fd;
    return cell;
}

/**
 *  设置头部控件
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    // 1.创建头部控件
    HeaderView *header = [HeaderView headerViewWithTableView:tableView];
    header.delegate = self;
    // 2.给header设置数据(给header传递模型)
    header.group = self.groups[section];
    return header;
}

-(void)headerViewDidClickTitle:(HeaderView *)headerView{
    [self.tableView reloadData];
}
@end
