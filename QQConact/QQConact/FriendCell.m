//
//  FriendCell.m
//  QQConact
//
//  Created by Geek on 16/5/23.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "FriendCell.h"
#import "Friend.h"

@implementation FriendCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"friend";
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil){
        cell = [[FriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return  cell;
}

-(void)setFriendData:(Friend *)friendData{
    _friendData = friendData;
    UIImage *img = [UIImage imageNamed:friendData.icon];
    self.imageView.image = img;
    self.textLabel.text = friendData.name;
    if(friendData.isVip){
        [self.textLabel setTextColor:[UIColor redColor]];
    }
    self.detailTextLabel.text = friendData.intro;
}
@end
