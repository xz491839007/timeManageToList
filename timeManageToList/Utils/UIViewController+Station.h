//
//  UIViewController+Station.h
//  继续的敏捷之路
//
//  Created by xuzhao on 15/10/8.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Station) <UIGestureRecognizerDelegate>

- (void)initNavigationWithTitle:(NSString *)title leftButton:(NSString *)leftBtnName rightButton:(NSString *)rightBtnName;

-(void)initNavigationWithImgAndTitle:(NSString *)title leftBtton:(NSString *)leftBtnName rightButImg:(UIImage *)rightImg rightBut:(NSString *)rightName navBackColor:(UIColor *)navcolor;

-(void)initNavigationWithImgAndTitle:(NSString *)title leftBtton:(NSString *)leftBtnName rightBut:(NSString *)rightName navBackColor:(UIColor *)navcolor;
@end
