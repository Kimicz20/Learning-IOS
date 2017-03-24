//
//  HeaderCell.m
//  QQConact
//
//  Created by Geek on 16/5/23.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "HeaderView.h"
#import "FriendGroup.h"

@interface HeaderView()
    @property (nonatomic, weak) UILabel *countView;
    @property (nonatomic, weak) UIButton *titleBtn;
@end

@implementation HeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView{
    static NSString *ID = @"header";
    
    HeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if(header == nil){
        header = [[HeaderView alloc] initWithReuseIdentifier:ID];
    }
    return  header;
}

/**
 *  在这个初始化方法中,HeaderView的frame\bounds没有值
 */
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        //添加控件
        
        //1.按钮控件
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        // 背景图片
        [titleBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [titleBtn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置按钮内部的左边箭头图片
        [titleBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮的内容左对齐
        titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置按钮的内边距
        titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        titleBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        // 设置按钮内部的imageView的内容模式为居中
        titleBtn.imageView.contentMode = UIViewContentModeCenter;
        // 超出边框的内容不需要裁剪
        titleBtn.imageView.clipsToBounds = NO;

        [self.contentView addSubview:titleBtn];
        self.titleBtn = titleBtn;
        [titleBtn addTarget:self action:@selector(clickTitleView) forControlEvents:UIControlEventTouchUpInside];
        //2.设置label
        UILabel *countView = [[UILabel alloc] init];
        countView.backgroundColor = [UIColor clearColor];
        countView.textColor = [UIColor grayColor];
        countView.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:countView];
        self.countView = countView;
    }
    return self;
}

/**
 *  点击title后将消息提交给代理
 */
-(void)clickTitleView{
    self.group.open = !self.group.isOpened;
    if([self.delegate respondsToSelector:@selector(headerViewDidClickTitle:)]){
        [self.delegate headerViewDidClickTitle:self];
    }
}

/**
 *  设置子控件的尺寸
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //1.按钮控件
    self.titleBtn.frame = self.bounds;
    
    //2.好友数目
    CGFloat countY = 0;
    CGFloat countW = 150;
    CGFloat countH = self.frame.size.height;
    CGFloat countX = self.frame.size.width - 10 -countW;
    self.countView.frame = CGRectMake(countX, countY, countW, countH);
}

-(void)setGroup:(FriendGroup *)group{
    _group = group;
    
    [self.titleBtn setTitle:group.name forState:UIControlStateNormal];
    
    [self.countView setText:[NSString stringWithFormat:@"%d/%d",group.online,group.friends.count]];
}

/**
 *  当一个控件被添加到父控件中就会调用
 */
-(void)didMoveToSuperview{
    if(self.group.open){
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}
@end
