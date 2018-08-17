//
//  HttpConnection.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import <Foundation/Foundation.h>"
#import "Task.h"

@interface HttpConnection : NSObject
/**
 *  1、用户登录
 *  post
 *  @param account 用户账户
 *  @param password 密码
 *  @param block 登录返回结果
 */
+ (void)loginWithUsername:(NSString *)account password:(NSString *)password block:(void(^)(NSInteger result,id response))block;
/**
 *  2、查询任务列表
 *  get
 *  @param block 登录返回结果
 */
+(void)getQueryTaskList:(void(^)(NSInteger result,id response))block;
/**
 *  3、完成任务
 *  get
 *  @param task 任务对象
 *  @param block 登录返回结果
 */
+(void)postFinishTask:(NSString *)Id task_remark:(NSString *)task_remark assess:(NSString *)assess end_time:(NSString *)end_time score:(NSString *)score block:(void(^)(NSInteger result,id response))block;
/**
 *  4、删除任务
 *  get
 *  @param task 任务对象
 *  @param block 登录返回结果
 */
+(void)postDelTask:(Task *)task block:(void(^)(NSInteger result,id response))block;

/**
 *  5、添加任务
 *  get
 *  @param block 登录返回结果
 */
+(void)postAddTask:(NSString *)taskName score:(NSString *)score repeat:(NSString *)repeat important:(NSString *)important category:(NSString *)category begin_time:(NSString *)begin_time end_time:(NSString *)end_time task_introduce:(NSString *)task_introduce  block:(void(^)(NSInteger result,id response))block;

/**
 *  6.查询任务能量
 *  get
 *  @param block 登录返回结果
 */
+(void)getQueryTaskListScore:(void(^)(NSInteger result,id response))block;

@end

#ifdef DEBUG

#define HTTPLog(fmt,...)     NSLog((@"HTTP->%s(%d):" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)

#else

#define HTTPLog(fmt,...)     NSLog(fmt,##__VA_ARGS__)

#endif
