//
//  Task.h
//  timeManageToList
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
///id
@property (nonatomic, copy) NSString *id;
///任务名称
@property (nonatomic, copy) NSString *task_name;
///任务介绍
@property (nonatomic, copy) NSString *task_introduce;
///任务完成备注
@property (nonatomic, copy) NSString *task_remark;
///开始时间
@property (nonatomic, copy) NSString *begin_time;
///结束时间
@property (nonatomic, copy) NSString *end_time;
///完成时间
@property (nonatomic, copy) NSString *result_time;
///实际执行持续时间(秒)
@property (nonatomic, copy) NSString *duration;
///是否重复（1否2是）
@property (nonatomic, copy) NSString *is_repeat;
///重复频率（1永不2每天3每周4每两周5每月6每年）
@property (nonatomic, copy) NSString *repeat_rate;
///得分
@property (nonatomic, copy) NSString *score;
///结果得分
@property (nonatomic, copy) NSString *result;
///重要等级（1不紧急不重要2不紧急重要3紧急不重要4紧急重要）
@property (nonatomic, copy) NSString *important;
///类别（简单的群组）
@property (nonatomic, copy) NSString *category;
///用户id
@property (nonatomic, copy) NSString *user_id;
///评分（-9～9）
@property (nonatomic, copy) NSString *assess;
///1准备执行2正在执行3超时4结束5放弃
@property (nonatomic, copy) NSString *del_type;
/// 超时标志（1.超时  2.已开始 2.未开始）
@property(nonatomic,assign) NSInteger TimeFlag;
/// 实时时间长度
@property(nonatomic,copy) NSString *TimeStr;

@end
