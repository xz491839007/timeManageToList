//
//  userModel.m
//  cnpcms
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 com.xz. All rights reserved.
//

#import "userModel.h"
#import "xzUtils.h"

// 宏定义属性名
#define USER_ID @"userId"
#define USER_AGE @"age"
#define USER_CITYID @"cityId"
#define USER_CODE @"code"
#define USER_DELFLAG @"delFlag"
#define USER_DEVICEID @"tjid"
#define USER_JOINTYPE @"tjuname"
#define USER_LOGINNAME @"gk"
#define USER_PERMISSION @"bank"
#define USER_PERMISSION_ARR @"bankArr"
#define USER_REALNAME @"bkno"
#define USER_REGIONID @"tel"
#define USER_ROLEID @"creattime"
#define USER_SEXNAME @"bd"
#define USER_SITEID @"empiric"
#define USER_POWER @"power"
#define POWER_MEET @"meet"
#define POWER_USER @"user"
#define POWER_COMP @"comp"
#define POWER_REGION @"region"
#define POWER_SITE @"site"
#define POWER_STAFFCH @"staffch"
#define POWER_NOTICE @"notice"
#define POWER_VER @"ver"
#define POWER_TAGS @"tags"
#define USER_REGID @"regid"
#define USER_INTEGRAL @"integral"
#define USER_QRCODE @"qrCodeUrl"
#define USER_CITY @"cityName"
#define USER_SITE @"siteName"
#define USER_SWITCH @"isswitchok"
#define USER_VERSION_POWER @"'power"


@implementation userModel

static userModel *instance = nil;

#pragma mark -init
+ (userModel *)getInstance
{
    @synchronized(self)
    {
        if (instance == nil) {
            instance = [[userModel alloc] init];
        }
        [instance loadUserInfo];
    }
    return instance;
}

-(void)loadUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userId=[userDefaults stringForKey:USER_ID];
    self.phone=[userDefaults stringForKey:USER_AGE];
    self.account=[userDefaults stringForKey:USER_CITYID];
    self.name=[userDefaults stringForKey:USER_CODE];
    self.gender=[userDefaults stringForKey:USER_DELFLAG];
    self.email=[userDefaults stringForKey:USER_DEVICEID];
}
//存储用户信息
-(void)saveUserInfo:(NSDictionary *)dict
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[dict stringForKeyX:@"id"] forKey:USER_ID];
    [userDefaults setValue:[dict stringForKeyX:@"account"] forKey:USER_CITYID];
    [userDefaults setValue:[dict stringForKeyX:@"name"] forKey:USER_CODE];
    [userDefaults setValue:[dict stringForKeyX:@"gender"] forKey:USER_DELFLAG];
    [userDefaults setValue:[dict stringForKeyX:@"email"] forKey:USER_DEVICEID];
    [userDefaults setValue:[dict stringForKeyX:@"phone"] forKey:USER_AGE];
    
    [userDefaults synchronize];
}
//重置用户信息
- (void)reSetUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_ID];
    [userDefaults removeObjectForKey:USER_AGE];
    [userDefaults removeObjectForKey:USER_CITYID];
    [userDefaults removeObjectForKey:USER_CODE];
    [userDefaults removeObjectForKey:USER_DELFLAG];
    [userDefaults removeObjectForKey:USER_DEVICEID];
    [userDefaults synchronize];
    //重置后调用
    [self loadUserInfo];
}

///更新用户数据
-(void)updataUserData:(NSString *)realname phone:(NSString*)phone age:(NSString *)age sex:(NSString *)sex
{
    ///更新资料
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_AGE];
    [userDefaults removeObjectForKey:USER_LOGINNAME];
    [userDefaults removeObjectForKey:USER_REALNAME];
    [userDefaults removeObjectForKey:USER_SEXNAME];
    [userDefaults setObject:age forKey:USER_AGE];
    [userDefaults setObject:phone forKey:USER_LOGINNAME];
    [userDefaults setObject:realname forKey:USER_REALNAME];
    [userDefaults setObject:sex forKey:USER_SEXNAME];
    [userDefaults synchronize];
}

@end
