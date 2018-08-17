//
//  AddTaskViewController.m
//  timeManageToList
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AddTaskTableViewCell.h"

#import "ToSelectViewController.h"
#import "WSDatePickerView.h"
#import "ToSelectViewController.h"


@interface AddTaskViewController ()<UITableViewDataSource,UITableViewDelegate,TextViewCellDelegate,UITextFieldDelegate>
{
    NSArray *category_opt;
    NSArray *repeat_options;
    NSArray *options;
    // 总表
    NSArray *dataArr;
    ///任务题目
    NSString *taskName;
    /// 开始时间
    NSString *beginTime;
    /// 结束时间
    NSString *endTime;
    ///重复
    NSString *repateFlag;
    ///重复数字排序
    NSString *repateType;
    ///积分
    NSString *score;
    ///重要性
    NSString *important;
    NSString *importantNum;
    ///类型
    NSString *category;
    ///介绍
    NSString *introduct;
}

///tabview
@property (weak, nonatomic) IBOutlet UITableView *MainTabView;


@end

@implementation AddTaskViewController


#pragma mark -界面初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    category_opt =@[@"软件",@"金融",@"生活",@"哲学",@"大数据和人工智能",@"娱乐",@"修身",@"基础学习",@"工作"];
    repeat_options =@[@"永不",@"每天",@"每周",@"每两周",@"每月",@"每年"];
    options =@[@"不紧急不重要",@"不紧急重要",@"紧急不重要",@"紧急重要"];
    dataArr =@[@[@"名称"],@[@"开始时间",@"结束时间",@"重复"],@[@"分数"],@[@"优先级",@"类型",@"介绍"]];
    
    if (self.mytask) {
            [self initNavigationWithImgAndTitle:@"修改任务" leftBtton:nil rightBut: @"完成" navBackColor:HexRGB(0x3CA7A3)];
    }else{
            [self initNavigationWithImgAndTitle:@"新添任务" leftBtton:nil rightBut:@"完成" navBackColor:HexRGB(0x3CA7A3)];
            //新添任务时，默认任务初始化
        ///重要性
        important = @"不紧急不重要";
        importantNum = @"1";
        ///类型
        category = @"软件";
        ///介绍
        introduct = @"暂无";
        repateFlag =@"永不";
        repateType = @"1";
    }
 
    [self.navigationItem.rightBarButtonItems[1] setAction:@selector(finishAction)];

    self.MainTabView.delegate =self;
    self.MainTabView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -完成事件
-(void)finishAction{
    if (self.mytask) {
        /// 修改模式
    }
    else{
        if (!taskName) {
            [SVProgressHUD showErrorWithStatus:@"任务名称没有填写"];
            return;
        }
        if (!score) {
            [SVProgressHUD showErrorWithStatus:@"任务分值没有填写"];
            return;
        }
        if (!beginTime.length || !endTime.length) {
            [SVProgressHUD showErrorWithStatus:@"任务时间没有选择"];
            return;
        }
        /// 新添模式
        [HttpConnection postAddTask:taskName score:score repeat:repateType important:importantNum category:category begin_time:beginTime end_time:endTime task_introduce:introduct block:^(NSInteger result, id response) {
            if (result==1) {
                [SVProgressHUD showSuccessWithStatus:@"任务添加完成"];
                // 延迟2秒后消失
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
            }
        }];
    }
}

#pragma mark - tabview

// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataArr[section];
    return arr.count;
}

//每个section头部标题高度（实现这个代理方法后前面 sectionFooterHeight 设定的高度无效）
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSArray *arr = dataArr[indexPath.section];
    NSString *str = arr[indexPath.row];
    AddTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"task"];
    switch (indexPath.section) {
        case 0:
        {
            cell =[[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][0];
            cell.delegate =self;
            if (taskName.length!=0) {
                cell.TitleTextView.text = taskName;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][1];
                    cell.TimeTitleLab.text = str;
                    if (beginTime.length!=0) {
                        cell.TimeInfoLab.text = beginTime;
                    }else{
                        cell.TimeInfoLab.text = @"请点击选择初始时间";
                    }
                }
                    break;
                case 1:
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][1];
                    cell.TimeTitleLab.text = str;
                    if (endTime.length!=0) {
                        cell.TimeInfoLab.text = endTime;
                    }else{
                        cell.TimeInfoLab.text = @"请点击选择结束时间";
                    } 
                }
                    break;
                case 2:
                {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][2];
                    cell.nextLab.text = str;
                    if (repateFlag.length!=0) {
                        cell.nextInfoLab.text = repateFlag;
                    }else{
                        cell.nextInfoLab.text = @"请选择重复次数";
                    }
                }
                    break;
                default:
                    break;
            }

        }
            break;
        case 2:
        {
            cell =[[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][3];
            cell.sourceTitleLab.text = str;
            cell.sourceInfoLab.delegate = self;
            // 分数
            if (score.length!=0) {
                cell.sourceInfoLab.text = score;
            }
            
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:
                {
                    // 优先级
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][2];
                    cell.nextLab.text = str;
                    if (important.length!=0) {
                        cell.nextInfoLab.text = important;
                    }else{
                        cell.nextInfoLab.text = @"请选择任务类型";
                    }
                }
                    break;
                case 1:
                {
                    // 类型
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][2];
                    cell.nextLab.text = str;
                    if (category.length!=0) {
                        cell.nextInfoLab.text = category;
                    }else{
                        cell.nextInfoLab.text = @"请选择任务类型";
                    }
                }
                    break;
                case 2:
                {
                    // 类型
                    cell = [[NSBundle mainBundle] loadNibNamed:@"AddTaskTableViewCell" owner:self options:nil][4];
                    cell.delegate = self;
                    cell.introLab.text = str;
                    if (introduct.length!=0) {
                        cell.introInfo.text = introduct;
                    }
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //开始时间
                    WSDatePickerView *datePick = [[WSDatePickerView alloc] initWithDate:DateStyleShowYearMonthDayHourMinute StartTime:nil endTime:nil CompleteBlock:^(NSDate *time) {
                        beginTime = [time stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
                        [self.MainTabView reloadData];
                    }];
                    datePick.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
                    [datePick show];
                }
                    break;
                case 1:
                {
                    if (beginTime.length!=0) {
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        //然后创建日期对象
                        NSDate *beginDate = [dateFormatter dateFromString:beginTime];
                        //结束时间
                        WSDatePickerView *datePick = [[WSDatePickerView alloc] initWithDate:DateStyleShowYearMonthDayHourMinute StartTime:beginDate endTime:nil CompleteBlock:^(NSDate *time) {
                            endTime = [time stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
                            [self.MainTabView reloadData];
                        }];
                        datePick.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
                        [datePick show];
                    } else{
                        //
                        [SVProgressHUD showErrorWithStatus:@"请先选择初始时间"];
                    }
                }
                    break;
                case 2:
                {
                    ToSelectViewController *toselect = [[ToSelectViewController alloc] initWithNibName:@"ToSelectViewController" bundle:nil];
                    toselect.dataArr = repeat_options;
                    toselect.block = ^(NSString *str, NSInteger index) {
                        repateFlag = str;
                        repateType = [NSString stringWithFormat:@"%ld",index+1];
                        [self.MainTabView reloadData];
                    };
                    [self.navigationController pushViewController:toselect animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    // 优先级
                    ToSelectViewController *toselect = [[ToSelectViewController alloc] initWithNibName:@"ToSelectViewController" bundle:nil];
                    toselect.dataArr = options;
                    toselect.block = ^(NSString *str, NSInteger index) {
                        important = str;
                        importantNum = [NSString stringWithFormat:@"%ld",index+1];
                        [self.MainTabView reloadData];
                    };
                    [self.navigationController pushViewController:toselect animated:YES];
                }
                    break;
                case 1:
                {
                    // 类型
                    ToSelectViewController *toselect = [[ToSelectViewController alloc] initWithNibName:@"ToSelectViewController" bundle:nil];
                    toselect.dataArr = category_opt;
                    toselect.block = ^(NSString *str, NSInteger index) {
                        category = str;
                        [self.MainTabView reloadData];
                    };
                    [self.navigationController pushViewController:toselect animated:YES];
                    
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark -TextViewCellDelegate
-(void)textViewChangeCell:(AddTaskTableViewCell* )cell textview:(UITextView *)txtview didChangeText:(NSString *)text{
    NSLog(@"%@======%@",txtview,text);
    if (txtview.tag == 101) {
        taskName = text;
    }
    else{
        introduct = text;
    }
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    score= textField.text;
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    score= textField.text;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 10; //这里是我的headerView和footerView的高度
    if (self.MainTabView.contentOffset.y<=sectionHeaderHeight&&self.MainTabView.contentOffset.y>=0) {
        self.MainTabView.contentInset = UIEdgeInsetsMake(-self.MainTabView.contentOffset.y, 0, 0, 0);
    } else if (self.MainTabView.contentOffset.y>=sectionHeaderHeight) {
        self.MainTabView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


@end
