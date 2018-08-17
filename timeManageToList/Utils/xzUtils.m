//
//  xzUtils.m
//  hmd
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 hmd. All rights reserved.
//

#import "xzUtils.h"
#import "NSData+KAES.h"


@implementation xzUtils

///nsdata转nsstring
+ (NSDate *)dateToString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *retdate = [dateFormatter dateFromString:str];
    return retdate;
}

+(NSString *)toTimeTemp
{
    // 当前时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}

//加密方法
+(NSString *)toEntryptString:(NSString* )straa
{
    NSData *srcData = [straa dataUsingEncoding:NSUTF8StringEncoding];

    NSData *edc=[srcData AES_ECB_EncryptWith:[secretKey dataUsingEncoding:NSUTF8StringEncoding]];

    NSData *edec32 = [[srcData AES_ECB_EncryptWith:[secretKey dataUsingEncoding:NSUTF8StringEncoding]] AES_ECB_DecryptWith:[secretKey dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *secrtStr;
    //加密后的字符串进行编码
    if (memcmp(srcData.bytes, edec32.bytes, srcData.length)==0) {

        NSString *str=[[NSString alloc] initWithData:edc encoding:NSUTF8StringEncoding];
        secrtStr=[edc base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        NSLog(@"AES_ecb_32 PASS:%@",str);
        NSLog(@"AES_ecb_32 PASS:%@",secrtStr);
    }
    return secrtStr;
}

///揭秘方法
+(NSString *)toDecrptString:(NSString *)straa{
    ///解码
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:straa options:0];

    return [[NSString alloc] initWithData:[decodedData AES_ECB_DecryptWith:[secretKey dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
}



///时间戳转时间
+(NSString *)timeTempToDate:(NSString *)timeTemp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *str = @"1490836840000";//毫秒
    NSInteger times = [timeTemp doubleValue]/1000;//秒
    NSString * timeStr = [NSString stringWithFormat:@"%ld",(long)times];

    NSTimeInterval timerInter = [timeStr doubleValue]+28800;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timerInter];

    return [formatter stringFromDate:confromTimesp];
}

///时间戳转时间(年月日)
+(NSString *)timeTempToYearDate:(NSString *)timeTemp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *str = @"1490836840000";//毫秒
    NSInteger times = [timeTemp doubleValue]/1000;//秒
    NSString * timeStr = [NSString stringWithFormat:@"%ld",(long)times];

    NSTimeInterval timerInter = [timeStr doubleValue]+28800;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timerInter];

    return [formatter stringFromDate:confromTimesp];
}


+ (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

//判断时间日期之间的间隔
+(NSString *)dateDuration:(NSString *)beginTime endTime:(NSString *)endTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *beginDate = [dateFormatter dateFromString:beginTime];
    NSDate *nowDate;
    //当前时间
    if (endTime.length!=0) {
        nowDate = [dateFormatter dateFromString:endTime];
    }
    else{
        ///当前时间
        nowDate = [NSDate date];
    }
    NSTimeInterval time = [nowDate timeIntervalSinceDate:beginDate];
    //计算天数、时、分、秒
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minutes = ((int)time)%(3600*24)%3600/60;
    int seconds = ((int)time)%(3600*24)%3600%60;
    NSString *dateContent = [[NSString alloc] initWithFormat:@"%i天%i小时%i分%i秒",days,hours,minutes,seconds];
    return dateContent;
}

//返回当前手机方法
+(NSDate *)toNowPhoneDate{
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *nowDate = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    // 返回系统当前时间
    return nowDate;
}

@end
