//
//  User.h
//  timeManageToList
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 com.xz.timeManageToList. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
///id
@property (nonatomic, copy) NSString *id;
///手机号
@property (nonatomic, copy) NSString *phone;
///任务介绍
@property (nonatomic, copy) NSString *account;
//名字
@property (nonatomic,copy) NSString *name;

@end
