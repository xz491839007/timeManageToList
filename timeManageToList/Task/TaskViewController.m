//
//  TaskViewController.m
//  timeManageToList
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "TaskViewController.h"
#import "AddTaskViewController.h"
#import "TaskTableViewCell.h"
#import "UILabel+LSLabelSize.h"
#import "MJRefresh.h"
#import "TimeConfig.h"
//#import "YYTimer.h"
#import "NSTimer+YYAdd.h"
#import "NSObject+YYModel.h"
#import "Task.h"
#import "NextTaskViewController.h"


@interface TaskViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    // 基本数据
    NSArray *dataArr;
    // 延伸时间数据
    // 循环方法，核心数据
    NSMutableArray *timeDataArr;
    BOOL isOne ;
    NSIndexPath *delIndexpath;
    // 所有的任务
    NSArray *AllDataArr;
    // 展示完成任务数
    NSInteger TaskFinishCount;
}

@property (strong, nonatomic) UIPanGestureRecognizer *pan;

@property (weak, nonatomic) IBOutlet UITableView *MainTabView;
@property (weak, nonatomic) UIView *HeadMainView;
- (IBAction)addTaskAction:(id)sender;

/// 完成任务
@property (weak, nonatomic) IBOutlet UILabel *ShowTaskInfoLab;
/// 展示任务点数
@property (weak, nonatomic) IBOutlet UILabel *ShowTaskScorceLab;

@end

@implementation TaskViewController
#pragma mark -界面查询
// 界面查询
-(void)queryTaskList{
    [HttpConnection getQueryTaskList:^(NSInteger result, id response) {
        if (result ==1) {
            dataArr  = response[@"data"];
            //更新数据
            [self ToDateArr];
            [self.MainTabView reloadData];
        }
        else{
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    }];
    [self.MainTabView.mj_header endRefreshing];
}


-(void)queryTaskSource{
    [HttpConnection getQueryTaskListScore:^(NSInteger result, id response) {
        if (result ==1) {
            NSLog(@"%@",response);
            if (!AllDataArr) {
                AllDataArr = [[NSArray alloc] init];
            }
            AllDataArr= response[@"data"];
            NSInteger TaskFinishCount = 0;
            for (NSDictionary *dict in AllDataArr) {
                if ([[dict stringForKeyX:@"del_type"] integerValue] == 4) {
                    TaskFinishCount++;
                }
            }
            self.ShowTaskInfoLab.text = [NSString stringWithFormat:@"任务总数：%@项,已完成：%ld项",response[@"count"],TaskFinishCount];
            self.ShowTaskScorceLab.text = [NSString stringWithFormat:@"任务积分：%@滴",response[@"score"]];
        }
        else{
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    }];
}

#pragma mark -设置界面
-(void)setHeadView{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self queryTaskList];
    [self queryTaskSource];
}

// 设置界面
- (void)viewDidLoad {
    [super viewDidLoad];
    isOne = true;
    [self initNavigationWithImgAndTitle:@"任务管理" leftBtton:@"" rightButImg:[UIImage imageNamed:@"新建培训"] rightBut:nil navBackColor:HexRGB(0x3CA7A3)];
    [self.navigationController.navigationItem.rightBarButtonItems[0] setAction:@selector(insetAction)];
    
    self.MainTabView.delegate = self;
    self.MainTabView.dataSource = self;
    if (!dataArr) {
        dataArr = [[NSArray alloc] init];
    }
    if (!timeDataArr) {
        timeDataArr = [[NSMutableArray alloc] init];
    }
    
    NSTimer *timer  = [NSTimer timerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        //更新数据
        [self ToDateArr];
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self.MainTabView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.MainTabView.rowHeight = UITableViewAutomaticDimension;
    self.MainTabView.mj_header =  [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self queryTaskList];
    }];
    [self.MainTabView.mj_header setIgnoredScrollViewContentInsetTop:20];
    
    // ---- kvo的观察着模式
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.MainTabView addObserver:self forKeyPath:ContentOffset options:options context:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -点击方法
-(void)insetAction{
    //
    AddTaskViewController * add =[[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:nil];
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark -tabviewDelgete
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return timeDataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//每个section头部标题高度（实现这个代理方法后前面 sectionFooterHeight 设定的高度无效）
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Task *task = timeDataArr[indexPath.section];
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task"];
    cell =[[NSBundle mainBundle] loadNibNamed:@"TaskTableViewCell" owner:self options:nil][0];
    
    cell.taskNameLab.text = task.task_name;
    cell.endTimeLab.text = [NSString stringWithFormat:@"截止时间：%@",task.end_time];
    // 任务
    NSString *times = [xzUtils dateDuration:task.begin_time endTime:task.end_time];
    cell.duationTimeLab.text = [NSString stringWithFormat:@"需用时：%@",times];
    ///是否超时
    if (task.TimeFlag == 1) {
        // 和手机比超时时间间隔
        cell.taskErrInfoLab.text = [NSString stringWithFormat:@"超时：%@",task.TimeStr];
    }else if(task.TimeFlag == 2){
        // 时间小于结束时间
        // 时间
        cell.taskErrInfoLab.text = [NSString stringWithFormat:@"已开始：%@",task.TimeStr];
    }else {
        cell.taskErrInfoLab.text = [NSString stringWithFormat:@"未开始"];
    }
    // 任务简介
    cell.taskInfoLab.text = [NSString stringWithFormat:@"任务简介：%@",task.task_introduce];
    //
    cell.taskSourceLab.text = [NSString stringWithFormat:@"能量值：%@滴",task.score];
    cell.taskTypeLab.text = [NSString stringWithFormat:@"任务类别：%@",task.category];
    if ([task.important isEqualToString:@"1"]) {
        cell.backView.backgroundColor = HexRGB(0xbfcbd9);
    }else if ([task.important isEqualToString:@"2"]){
        cell.backView.backgroundColor = HexRGB(0xa9d86e);
    } else if ([task.important isEqualToString:@"3"]){
        cell.backView.backgroundColor = HexRGB(0xfab6b6);
    } else if ([task.important isEqualToString:@"4"]){
        cell.backView.backgroundColor = HexRGB(0xff4d51);
    }
    cell.path = indexPath;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//让tableView可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"删除任务会扣除更多的惩罚积分，您确认继续嘛？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        delIndexpath = indexPath;
        NSLog(@"点击了删除");
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了。。%ld",(long)indexPath.section);
        
        tableView.editing = NO;
    }];
    action0.backgroundColor = [UIColor darkGrayColor];
    return @[deleteRowAction, action0];
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    //完成按钮
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"完成" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //
        NextTaskViewController * nextTask = [[NextTaskViewController alloc] initWithNibName:@"NextTaskViewController" bundle:nil];
        NSLog(@"%@",timeDataArr[indexPath.section]);
        Task *mytask =timeDataArr[indexPath.section];
        nextTask.myTask = mytask;
        [self.navigationController pushViewController:nextTask animated:YES];
    }];
    deleteRowAction.backgroundColor = [UIColor greenColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

#pragma mark -数据处理方法
//数据处理
-(void)ToDateArr {
     // 进行数据延伸升级
    if (dataArr.count!=0) {
        if (timeDataArr.count!=0) {
            timeDataArr = [[NSMutableArray alloc] init];
        }
        // 做成对象
        NSInteger i=0;
        for (NSDictionary *dict in dataArr) {
            Task *myTask = [Task modelWithDictionary:dict];
            if ([self isErrInfo:myTask.end_time]) {
                // 超时
                myTask.TimeFlag = 1;
                // 当前时间和截止时间进行比较
                myTask.TimeStr=[xzUtils dateDuration:myTask.end_time endTime:@""];
            }else{
                if ([self isErrInfo:myTask.begin_time]) {
                    myTask.TimeFlag = 2;
                    myTask.TimeStr=[xzUtils dateDuration:myTask.begin_time endTime:@""];
                }else{
                    myTask.TimeFlag = 3;
                }
            }
            [timeDataArr addObject:myTask];
            // 发送报告
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"TimeNotification_%ld_0",i] object:myTask];
            i++;
        }
        
    }
}

#pragma mark  -是否超时
/// 是否超时
-(BOOL)isErrInfo:(NSString *)endTime{
    //先将UTC字符串转为UTCDate;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Beijing"]];
    // NSDate* d = [f dateFromString:s];如果是24小时格式会返回nil
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dates = [formatter dateFromString:endTime];
    NSDate *nowDate = [xzUtils toNowPhoneDate];
    NSComparisonResult result = [nowDate compare:dates];
    // 返回1 - 过期, 0 - 相等, -1 - 没过期
    if (result == NSOrderedDescending) {
        // 过期了
        return true;
    }
    else if (result == NSOrderedAscending){
        return false;
    }
    else{
        return false;
    }
    
}
#pragma mark -删除方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        // 确认
        if (delIndexpath) {
            Task *delTask = timeDataArr[delIndexpath.section];
            [HttpConnection postDelTask:delTask block:^(NSInteger result, id response) {
                if (result ==1) {
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    // 延迟2秒后消失
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        // 重新刷新
                        [self queryTaskList];
                    });
                }else{
                    [SVProgressHUD showErrorWithStatus:response[@"message"]];
                }
            }];
        }
        
    }
}
#pragma mark -三D反转
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    NSLog(@"========%@=====",change);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    // 遇到这些情况就直接返回
    if (!self.MainTabView.userInteractionEnabled) return;
    if ([keyPath isEqualToString:MJRefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}
#pragma mark -添加任务
- (IBAction)addTaskAction:(id)sender {
    //
    AddTaskViewController * add= [[AddTaskViewController alloc] initWithNibName:@"AddTaskViewController" bundle:nil];
    
    [self.navigationController pushViewController:add animated:YES];
}
@end
