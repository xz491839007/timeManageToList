//
//  AddTaskTableViewCell.m
//  timeManageToList
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import "AddTaskTableViewCell.h"
@interface AddTaskTableViewCell()<UITextViewDelegate>{
    
}

@end

@implementation AddTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowWithNotification:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidChange:(UITextView *)textView{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.delegate respondsToSelector:@selector(textViewChangeCell:textview:didChangeText:)]) {
        [self.delegate textViewChangeCell:self textview:textView didChangeText:textView.text];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (void)keyBoardWillShowWithNotification:(NSNotification *)notification {
    
    //取出键盘最终的frame
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //取出键盘弹出需要花费的时间
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
     UITableView *tableView = [self tableView];
    
    //获取最佳位置距离屏幕上方的距离
    if ((self.introInfo.origin.y + self.introInfo.size.height) >  ([UIScreen mainScreen].bounds.size.height - rect.size.height)) {//键盘的高度 高于textView的高度 需要滚动
        [UIView animateWithDuration:duration animations:^{
            tableView.contentOffset = CGPointMake(0, 64 + self.introInfo.origin.y + self.introInfo.size.height - ([UIScreen mainScreen].bounds.size.height - rect.size.height));
        }];
    }
    
}
@end
