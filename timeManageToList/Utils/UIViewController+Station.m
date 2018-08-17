//
//  UIViewController+Station.h
//  LINK
//
//  Created by mark on 15/10/8.
//  Copyright (c) 2015年 LINK. All rights reserved.
//


#import "UIViewController+Station.h"

@implementation UIViewController (Station)

- (void) initNavigationWithTitle:(NSString *)title leftButton:(NSString *)leftBtnName rightButton:(NSString *)rightBtnName
{
    if (!leftBtnName) {

        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = 0;
//
//        UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc] init];
//        leftButtonItem.customView = leftButton;
        
     UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
        leftButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftButtonItem,nil];

    }
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;

    UIFont *font = [UIFont systemFontOfSize:18];
    label.font = font;
    label.text = title;
    
    self.navigationItem.titleView = label;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

-(void)initNavigationWithImgAndTitle:(NSString *)title leftBtton:(NSString *)leftBtnName rightButImg:(UIImage *)rightImg rightBut:(NSString *)rightName navBackColor:(UIColor *)navcolor;
{
    if (title) {

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;

        UIFont *font = [UIFont systemFontOfSize:18];
        label.font = font;
        label.text = title;

        self.navigationItem.titleView = label;
    }
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;


    if (!leftBtnName) {
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
        leftButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftButtonItem,nil];
    }
    if (rightName) {
        UIBarButtonItem *rightBtuItem = [[UIBarButtonItem alloc]initWithTitle:rightName style:UIBarButtonItemStylePlain target:self action:nil];
        rightBtuItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBtuItem,nil];
    }
    else{
        if (rightImg) {
            
            UIBarButtonItem *rightBtuItem = [[UIBarButtonItem alloc]initWithImage:rightImg style:(UIBarButtonItemStylePlain) target:self action:nil];
            rightBtuItem.tintColor = [UIColor whiteColor];
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBtuItem,nil];
        }
    }
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.barTintColor = navcolor;

}
-(void)initNavigationWithImgAndTitle:(NSString *)title leftBtton:(NSString *)leftBtnName rightBut:(NSString *)rightName navBackColor:(UIColor *)navcolor;
{
    if (title) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        UIFont *font = [UIFont systemFontOfSize:18];
        label.font = font;
        label.text = title;
        
        self.navigationItem.titleView = label;
    }
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = 0;
    
    
    if (leftBtnName) {
     
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithTitle:leftBtnName style:(UIBarButtonItemStylePlain) target:self action:nil];
        leftButtonItem.tintColor = [UIColor whiteColor];
        [leftButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftButtonItem,nil];
    }else{
        UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStylePlain) target:self action:@selector(back)];
        leftButtonItem.tintColor = [UIColor whiteColor];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,leftButtonItem,nil];
    }
    
    if (rightName) {
        UIBarButtonItem *rightBtuItem = [[UIBarButtonItem alloc]initWithTitle:rightName style:UIBarButtonItemStylePlain target:self action:nil];
        rightBtuItem.tintColor = [UIColor whiteColor];
        [rightBtuItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,rightBtuItem,nil];
    }
    
    //    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationBar.barTintColor=navcolor;
    
    
}
- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) backNotification:(NSNotification *) note
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
