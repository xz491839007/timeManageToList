//
//  xzUtils.h
//  hmd
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 hmd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface xzUtils : NSObject

//返回时间戳
+(NSString*)toTimeTemp;
//加密方法
+(NSString *)toEntryptString:(NSString* )straa;
///揭秘方法
+(NSString *)toDecrptString:(NSString *)straa;
//返回当前手机方法
+(NSDate *)toNowPhoneDate;

///时间戳转时间
+(NSString *)timeTempToDate:(NSString *)timeTemp;
///时间戳转时间(年月日)
+(NSString *)timeTempToYearDate:(NSString *)timeTemp;
///判断是否为全数字
+ (BOOL) deptNumInputShouldNumber:(NSString *)str;
///nsdata转nsstring
+ (NSDate *)dateToString:(NSString *)str;
//判断时间日期之间的间隔
+(NSString *)dateDuration:(NSString *)beginTime endTime:(NSString *)endTime;

@end
