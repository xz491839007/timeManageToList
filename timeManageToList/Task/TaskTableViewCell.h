//
//  TaskTableViewCell.h
//  timeManageToList
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell
// 获取table view cell 的indexPath
@property (nonatomic, weak) NSIndexPath *m_indexPath;
@property (nonatomic)BOOL  m_isDisplayed;

@property (weak, nonatomic) IBOutlet UILabel *taskNameLab;
/// 任务信息高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taskNameHeightCon;
/// 截止时间高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endTimeHeightCon;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
/// 区间时间高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *duationTimeHeightCon;
@property (weak, nonatomic) IBOutlet UILabel *duationTimeLab;
///任务简介高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taskInfoHeightCon;
@property (weak, nonatomic) IBOutlet UILabel *taskInfoLab;
/// 任务类型
@property (weak, nonatomic) IBOutlet UILabel *taskTypeLab;
///
@property (weak, nonatomic) IBOutlet UILabel *taskSourceLab;
/// 任务错误
@property (weak, nonatomic) IBOutlet UILabel *taskErrInfoLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taskErrInfoHeightCon;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(weak,nonatomic)IBOutlet NSIndexPath *path;

@end
