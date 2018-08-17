//
//  NetController.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetApiClient.h"

@interface NetController : NSObject

///上传照片接口1
+(void)uploadImageWithImage:(UIImage *)iamges parameter:(NSDictionary *)parameter success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;
///上传照片
+(void)uploadImageWithArray:(NSMutableArray *)imageArray parameter:(NSDictionary *)parameter success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;

///get请求
+(void)httpRequestGetWithPath:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;
///带参数的post请求
+(void)httpRequestWithPath:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;

///post请求
+(void)httpRequestWithPath:(NSString *)path success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;


///基础下载
+(NSURLSessionTask *)httpConnectionWithRequest:(NSUInteger) type
                                           URL:(NSString *)url
                                        params:(NSDictionary *)params
                                       success:(void(^)(id response))success
                                          fail:(void(^)(NSError *error))fail;

///第三方登录
+(void) thirdRequestGet:(NSString *)userNick Path:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail;


+(void)postRequestWithURL:(NSString *)url content:(NSString *)text;


@end
