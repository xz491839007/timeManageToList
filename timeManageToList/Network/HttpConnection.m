//
//  HttpConnection.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import "HttpConnection.h"
#import "NetController.h"
#import "xzUtils.h"


static NSString *DEFAULT_LOGIN_PWD = @"";
static NSString *DEFAULT_LOGIN = @"";

@implementation HttpConnection

/**
 *  1、用户登录
 *  post
 *  @param account 用户账户
 *  @param password 密码
 *  @param block 登录返回结果
 */
+ (void)loginWithUsername:(NSString *)account password:(NSString *)password block:(void(^)(NSInteger result,id response))block
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:account,@"account",password,@"password", nil];
    [NetController httpRequestWithPath:URL_LOGIN param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"登录失败");
    }];
}
/**
 *  2、查询任务列表
 *  get
 *  @param block 登录返回结果
 */
+(void)getQueryTaskList:(void(^)(NSInteger result,id response))block{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[userModel getInstance].userId,@"userId", nil];
    [NetController httpRequestGetWithPath:URL_SENDCODE param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
}

/**
 *  3、完成任务
 *  get
 *  @param task 任务对象
 *  @param block 登录返回结果
 */
+(void)postFinishTask:(NSString *)Id task_remark:(NSString *)task_remark assess:(NSString *)assess end_time:(NSString *)end_time score:(NSString *)score block:(void(^)(NSInteger result,id response))block{
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",task_remark,@"task_remark",assess,@"assess",end_time,@"end_time",score,@"score", nil];
    
    [NetController httpRequestWithPath:URL_FINISHTASK param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
    
}

/**
 *  4、删除任务
 *  get
 *  @param task 任务对象
 *  @param block 登录返回结果
 */
+(void)postDelTask:(Task *)task block:(void(^)(NSInteger result,id response))block {
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:task.id,@"id",task.end_time,@"end_time",task.score,@"score", nil];
    [NetController httpRequestWithPath:URL_FINISHTASK param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
}

/**
 *  5、添加任务
 *  get
 *  @param block 登录返回结果
 */
+(void)postAddTask:(NSString *)taskName score:(NSString *)score repeat:(NSString *)repeat important:(NSString *)important category:(NSString *)category begin_time:(NSString *)begin_time end_time:(NSString *)end_time task_introduce:(NSString *)task_introduce  block:(void(^)(NSInteger result,id response))block {
    NSString *is_repeat = @"1";
    if (![repeat isEqualToString:@"1"]) {
        is_repeat = @"2";
    }
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:taskName,@"task_name",[userModel getInstance].userId,@"user_id",score,@"score",is_repeat,@"is_repeat",repeat,@"repeat_rate",important,@"important",category,@"category",begin_time,@"begin_time",end_time,@"end_time",task_introduce,@"task_introduce", nil];
    [NetController httpRequestWithPath:URL_ADDTASK param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
}

/**
 *  6.查询任务能量
 *  get
 *  @param block 登录返回结果
 */
+(void)getQueryTaskListScore:(void(^)(NSInteger result,id response))block{
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[userModel getInstance].userId,@"userId", nil];
    [NetController httpRequestGetWithPath:URL_GETUSERSCORE param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
    
}

/**
 *  7、修改任务
 *  post
 *  @param block 登录返回结果
 */
+(void)postEditTask:(NSString *)taskName Id:(NSString *)Id score:(NSString *)score repeat:(NSString *)repeat important:(NSString *)important category:(NSString *)category begin_time:(NSString *)begin_time end_time:(NSString *)end_time task_introduce:(NSString *)task_introduce  block:(void(^)(NSInteger result,id response))block{
    
    NSString *is_repeat = @"1";
    if (![repeat isEqualToString:@"1"]) {
        is_repeat = @"2";
    }
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:Id,@"id",taskName,@"task_name",[userModel getInstance].userId,@"user_id",score,@"score",is_repeat,@"is_repeat",repeat,@"repeat_rate",important,@"important",category,@"category",begin_time,@"begin_time",end_time,@"end_time",task_introduce,@"task_introduce", nil];
    [NetController httpRequestWithPath:URL_EDITTASK param:dict success:^(id response) {
        if ([response isKindOfClass:[NSDictionary class]]) {
            NSLog(@"%@", response);
            NSNumber *result = response[@"status"];
            block([result integerValue],response);
        }
    } fail:^(NSError *error) {
        NSLog(@"查询失败");
    }];
    
}


//querysecondlevelmenu
@end
