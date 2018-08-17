//
//  Networking.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#ifndef IntelligentStation_Networking_h
#define IntelligentStation_Networking_h
#endif

//最新的afnetworking的封装库
#import "NetApiClient.h"
#import "NetController.h"
#import "HttpConnection.h"
//#import "LoginViewController.h"
#import "SVProgressHUD.h"

///分页数
#define kPageLength @"20"
////正式服务器
#define BaseUrl @"http://118.24.116.170:3000/"
//测试服务器
//#define BaseUrl @"http://192.168.0.123:3000/"

#define secretKey @"fe&gf2hg34h3fr34yryr464f@$5ds!fs"

/// 1.登录接口
#define URL_LOGIN @"api/login"
/// 2.查询任务列表
#define URL_SENDCODE @"api/querytask"
/// 3.完成接口
#define URL_FINISHTASK @"api/finishtask"
///4.删除任务
#define URL_DELTASK @"api/deltask"
///5.新添任务
#define URL_ADDTASK @"api/addtask"
///6.查询任务能量
#define URL_GETUSERSCORE @"api/getUserScore"
///7.更改任务
#define URL_EDITTASK @"api/eaittask"

//图片上传json
#define API_MODIFY_USER_HEAD @"cnpcms/appreq/uploadimg"
//支付宝支付接口
#define API_PAY_AILI @""
//微信支付接口
#define API_PAY_WEIXIN @""

/*
 @brief 按钮标题常量
 */
#define BUTTON_EDIT @"编辑"///编辑
#define BUTTON_COMPLETE @"完成"///完成
#define BUTTON_CALCULATE @"结算"///结算
#define BUTTON_DELETE @"删除"///删除
#define BUTTON_SAVE @"保存"///保存
#define BUTTON_MY_LIVE @"我要直播"///我要直播
#define BUTTON_GO_PAY @"去支付"///去支付
#define BUTTON_CANCEL_ORDER @"取消订单"///取消订单
#define BUTTON_RETURN @"退货"///退货
#define BUTTON_CONFIRM_RECEIVE @"确认收货"///确认收货
#define BUTTON_DELETE_ORDER @"删除订单"///删除订单
#define BUTTON_BUY_AGAIN @"再次购买"///再次购买
#define BUTTON_STAY_PAY @"等待支付"///等待支付
#define BUTTON_STAY_SEND @"等待发货"///等待发货
#define BUTTON_STAY_RECEIVE @"等待收货"///等待收货
#define BUTTON_ORDER_SUCCESS @"交易成功"///交易成功
#define BUTTON_ORDER_CANCEL @"已取消"///已取消

/**
 @brief 信息提示
 */
#define MESSAGE_EXIT_SYSTEM @"再次点击退出应用"///再次点击退出应用
#define MESSAGE_ALREADY_SIGN_IN @"您今天已经签过到了"///您今天已经签过到了
#define MESSAGE_EXIT_SYSTEM @"再次点击退出应用"///再次点击退出应用
#define MESSAGE_ALREADY_SIGN_IN @"您今天已经签过到了"///您今天已经签过到了
#define MESSAGE_PAY_STATE_SUCCESS @"支付成功"///支付成功
#define MESSAGE_PAY_STATE_CONFIRM @"支付结果确认中"///支付结果确定中
#define MESSAGE_PAY_STATE_CANCEL @"支付取消"///支付取消
#define MESSAGE_PAY_STATE_FAULURE @"支付失败"///支付失败
#define MESSAGE_NOT_LOGIN @"您还没有登录"///您还没有登陆
/**
 @brief 内部版本号
 */
#define hmd_version @"6"

/**
 @brief 手机号
 */
#define swj_phone @"4000239030"

#define TABBAR_HIGH 64

/*
 @brief
 */
#define UmengAppkey @"57147e76e0f55ad6420001cd"


