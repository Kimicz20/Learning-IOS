//
//  ViewController.m
//  QQ聊天布局
//
//  Created by Geek on 16/5/11.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "MessageCell.h"


@interface ViewController()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (nonatomic,strong) NSMutableArray *messageF;
    @property (weak, nonatomic) IBOutlet UITextField *textField;
    @property (nonatomic, strong) NSDictionary *autoreply;
@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden{
    return NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    //2.去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //3.不允许选中
    self.tableView.allowsSelection = NO;
    
    //4.键盘通知设置
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //输入框 左端
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark 清除监听器
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 键盘弹出时 移动底部工具栏
-(void)keyboardWillChangeFrame:(NSNotification *)notice{

//    NSLog(@"%@",notice);
    //1.获取键盘上移时间
    CGFloat duration = [notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //2.获取键盘上移高度
    CGRect keyboardFrame = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
//    NSLog(@"屏幕高度：%f",self.view.frame.size.height);
    //3.工具栏要上升的高度 （由于有上栏黑框 所以减去20）
    CGFloat highMenu = keyboardFrame.origin.y -  self.view.frame.size.height - 20;
    //整个底部工具栏向上移动
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, highMenu);
    }];
}

#pragma mark 点击了return按钮(键盘最右下角的按钮)就会调用
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"%@",textField);
    // 1.自己发一条消息
    [self addMessage:textField.text type:MessageTypeMe];
    
    // 2.自动回复一条消息
    NSString *reply = [self replayWithText:textField.text];
    [self addMessage:reply type:MessageTypeOther];
    
    // 3.清空文字
    self.textField.text = nil;
    
    return YES;
}

#pragma mark 添加一条消息
-(void)addMessage:(NSString *)message type:(MessageType)type{
    // 1.数据模型(设置数据)
    Message *msg = [[Message alloc] init];
    msg.text = message;
    msg.type = type;
    
    // 1.1设置数据模型的时间
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    msg.time = [df stringFromDate:now];
    
    // 1.2看是否需要隐藏时间
    MessageFrame *mf = [_messageF lastObject];
    msg.ISSame = [msg.time isEqualToString:mf.message.time];
    
    // 2.frame模型
    MessageFrame *newMf = [[MessageFrame alloc] init];
    newMf.message = msg;
    [self.messageF addObject:newMf];
    
    // 3.刷新表格
    [self.tableView reloadData];
    
    // 4.自动滚动表格到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageF.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSDictionary *)autoreply
{
    if (_autoreply == nil) {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}

#pragma mark 自动回复消息
-(NSString *)replayWithText:(NSString *)message{
    for (int i = 0; i<message.length; i++) {
        NSString *word = [message substringWithRange:NSMakeRange(i, 1)];
        
        if (self.autoreply[word]) return self.autoreply[word];
    }
    
    return @"你真是厉害啊";
}

#pragma mark 滚动UItableView时隐藏键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}



#pragma mark 懒加载方式,字典转模型
-(NSMutableArray *)messageF{
    if(_messageF==nil){
        //1.获取字典
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        //2.字典转模型
        NSMutableArray *msgArray = [NSMutableArray array];
        for(NSDictionary *dict in dictArray){
            
            //创建当前message
            Message *nowMsg = [Message messageWithDict:dict];
            
            //获取上一个message的发送时间
            MessageFrame *lastF = [msgArray lastObject];
            Message *lastMsg = lastF.message;
            
            //判断时间是否相同
            nowMsg.ISSame = [nowMsg.time isEqualToString:lastMsg.time];
          
            MessageFrame *messageF = [[MessageFrame alloc] init];
            messageF.message = nowMsg;

            [msgArray addObject:messageF];
        }
        _messageF = msgArray;
    }
    return _messageF;
}

#pragma mark table行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageF.count;
}

#pragma mark 设置每行的cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCell *msgCell = [MessageCell cellWithTableView:tableView];
    //传递数据
    msgCell.messageF = self.messageF[indexPath.row];
    
    return msgCell;
}

#pragma mark 设置每行cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.messageF[indexPath.row] cellHeight];
}
@end
