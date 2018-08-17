//
//  userModel.h
//  cnpcms
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 com.xz. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface userModel : NSObject

/**
 @brief 获取当前User对象的单例
 @returns User的单例对象
 @todo
 -# 判断当前对象是否存在；
 -# 如果存在，则返回当前对象；
 -# 如果不存在，则创建对象并返回。
 */
+ (userModel *)getInstance;
//data =     {
//    account = admin;
//    "card_no" = 123456;
//    "card_type" = "\U5fae\U4fe1\U8d26\U53f7";
//    email = "491839007@qq";
//    gender = 1;
//    id = 1;
//    image = "<null>";
//    name = abc;
//    phone = 13112345678;
//    role = "<null>";
//};
///id
@property (nonatomic, strong) NSString *userId;
///手机号
@property (nonatomic, strong) NSString *phone;
///任务介绍
@property (nonatomic, strong) NSString *account;
//名字
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *gender;        //userId
@property (nonatomic,strong) NSString *email;

//加载
-(void)loadUserInfo;
//存储用户信息
-(void)saveUserInfo:(NSDictionary *)dict;
//重置用户信息
- (void)reSetUserInfo;
///存储权限信息
-(void)savaPowerInfo;
///更新用户数据
-(void)updataUserData:(NSString *)realname phone:(NSString*)phone age:(NSString *)age sex:(NSString *)sex;
///存储通知id信息
-(void)saveRegId:(NSString *)regId;
///存储switch信息
-(void)updataSwitch:(NSString *)isSwitch;

@end
