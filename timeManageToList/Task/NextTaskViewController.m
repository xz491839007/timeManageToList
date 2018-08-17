//
//  NextTaskViewController.m
//  timeManageToList
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "NextTaskViewController.h"
#import "WTKStarView.h"
#import "UIView+YYAdd.h"

@interface NextTaskViewController ()
{
    NSArray *finishArr;
    
    NSInteger value_int;
    float value_float ;
}

@property (weak, nonatomic) IBOutlet UILabel *showLab;
//星星
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UIButton *toOverBtu;
//时间
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)toOverTaskAction:(id)sender;

@end

@implementation NextTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    [self initNavigationWithImgAndTitle:@"完成评价" leftBtton:nil rightBut:nil navBackColor:HexRGB(0x3CA7A3)];
    finishArr = @[@"失败",@"极差", @"失望",@"巨大代价",@"鸡肋",@"一般", @"满意", @"惊喜",@"巨大成功",@"完美"];
    WTKStarView *starview = [[WTKStarView alloc] initWithFrame:CGRectMake(0, 0, self.starView.width, self.starView.height) starSize:CGSizeMake(0, 0) withStyle:WTKStarTypeFloat];
    starview.star = 0;
    starview.starBlock = ^(NSString *value) {
        value_float = [value floatValue] *2;
        if (value_float>1.0f) {
            value_int = [[NSNumber numberWithFloat:value_float] integerValue];
        }else{
            if (value_float<=0.5f) {
                value_int=0;
            }else{
                value_int =1;
            }
        }
        if (value_int>9) {
            value_int = 9;
        }
        self.showLab.text = finishArr[value_int];
    };
    [self.starView addSubview:starview];
    self.toOverBtu.layer.borderWidth =1;
    self.toOverBtu.layer.cornerRadius= 5;
    self.textView.layer.borderWidth = 1;
    // 回收键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
    tapGestureRecognizer.delegate=self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -完成
// 完成任务
- (IBAction)toOverTaskAction:(id)sender {
    self.myTask.task_remark = self.textView.text;
    if (value_float*2>10) {
        value_float=5.0f;
    }
    self.myTask.assess = [NSString stringWithFormat:@"%.2f",value_float*2];
    
    [HttpConnection postFinishTask:self.myTask.id task_remark:self.textView.text assess:[NSString stringWithFormat:@"%.2f",value_float*2] end_time:self.myTask.end_time score:self.myTask.score  block:^(NSInteger result, id response) {
        if (result==1) {
            [SVProgressHUD showSuccessWithStatus:@"任务完成"];
            // 延迟2秒后消失
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else{
            [SVProgressHUD showErrorWithStatus:response[@"message"]];
        }
    }];
    
}

- (void)handleTapFrom:(UIGestureRecognizer *)gestureFrom
{
    // 关闭键盘
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
@end
