//
//  AddTaskTableViewCell.h
//  timeManageToList
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddTaskTableViewCell;

@protocol TextViewCellDelegate <NSObject>
@optional
-(void)textViewChangeCell:(AddTaskTableViewCell* )cell textview:(UITextView *)txtview didChangeText:(NSString *)text;
@end


@interface AddTaskTableViewCell : UITableViewCell

//题目
@property (weak, nonatomic) IBOutlet UITextView *TitleTextView;
@property (weak, nonatomic) id<TextViewCellDelegate> delegate;
// 开始时间 结束时间
@property (weak, nonatomic) IBOutlet UILabel *TimeTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeInfoLab;

//跳转
@property (weak, nonatomic) IBOutlet UILabel *nextLab;
@property (weak, nonatomic) IBOutlet UILabel *nextInfoLab;
///分数
@property (weak, nonatomic) IBOutlet UILabel *sourceTitleLab;
@property (weak, nonatomic) IBOutlet UITextField *sourceInfoLab;

/// 介绍
@property (weak, nonatomic) IBOutlet UILabel *introLab;
@property (weak, nonatomic) IBOutlet UITextView *introInfo;

@end

