//
//  UtilsMacro.h
//  LINK
//
//  Created by mark on 15/11/23.
//  Copyright © 2015年 LINK. All rights reserved.
//

#ifndef UtilsMacro_UtilsMacro_h
#define UtilsMacro_UtilsMacro_h

#define kSearchbarHeight 44

///----------------功能-------------------------

//-----------------------常见的颜色--------------------------
#define MainClor  [UIColor colorWithRed:(100/255.0) green:( 100/ 255.0) blue:(100 / 255.0) alpha:1.0]

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//获取当前屏幕的高度 （去掉状态栏）
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
//获取当前屏幕的宽度 （去掉状态栏）
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

//获取导航栏高度
#define kNavigationControllerHeight(self) self.navigationController.navigationBar.frame.size.height;

//获取状态栏高度
#define kStateHeight [UIApplication sharedApplication].statusBarFrame.size.height

//判断设备的操做系统是不是ios7
#define IOS7 ([[[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]

#define iphone4    (([[UIScreen mainScreen] bounds].size.height) == 480)

//判断当前设备是不是iphone5
#define kScreenIphone5    (([[UIScreen mainScreen] bounds].size.height)>=568)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
//----------------------颜色类---------------------------

//color
#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]



//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#endif
