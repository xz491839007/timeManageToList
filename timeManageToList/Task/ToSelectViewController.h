//
//  ToSelectViewController.h
//  timeManageToList
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  void (^returnToSelectBlock)(NSString *str,NSInteger index);

@interface ToSelectViewController : UIViewController
//回调
@property(nonatomic,strong) returnToSelectBlock block;
@property(nonatomic,strong) NSArray *dataArr;
// 1是重复
@property(nonatomic,assign) NSInteger num;

@end
