//
//  TaskTableViewCell.m
//  timeManageToList
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Task.h"
@interface TaskTableViewCell()
{
    // 设置通信
    BOOL isSetNotice;
}

@end

@implementation TaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    isSetNotice = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//促发时间
- (void)timeDoneNotification:(NSNotification *)notification {
    Task * taskDic = [notification object];
    ///是否超时
    if (taskDic.TimeFlag == 1) {
        // 和手机比超时时间间隔
        self.taskErrInfoLab.text = [NSString stringWithFormat:@"超时：%@",taskDic.TimeStr];
    }else if(taskDic.TimeFlag == 2){
        // 时间小于结束时间
        // 时间
        self.taskErrInfoLab.text = [NSString stringWithFormat:@"已开始：%@",taskDic.TimeStr];
    }else {
        self.taskErrInfoLab.text = [NSString stringWithFormat:@"未开始"];
    }
    // 任务简介
}

-(void)setPath:(NSIndexPath *)path{
    // 监听通知
    if (isSetNotice) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeDoneNotification:) name:[NSString stringWithFormat:@"TimeNotification_%ld_%ld",(long)path.section,(long)path.row] object:nil];
        isSetNotice = false;
    }

}

@end
