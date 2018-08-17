//
//  NetController.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


#import "NetController.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "xzUtils.h"

@implementation NetController

static NSMutableArray *tasks;

+(NSMutableArray *)tasks{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

#pragma mark 第三方登录

///第三方登录接口
+(void) thirdRequestGet:(NSString *)userNick Path:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{
    [NetController httpConnectionWithRequest:2 URL:path params:param success:success fail:fail];
}

#pragma mark GET请求
///get请求
+(void)httpRequestGetWithPath:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{
    
    [SVProgressHUD show];
    [NetController httpConnectionWithRequest:1 URL:path params:param success:success fail:fail];
}

#pragma mark POST请求
///带参数的post请求
+(void)httpRequestWithPath:(NSString *)path param:(NSDictionary *)param success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{

    if(!path || path.length == 0)return;
//    NSLog(@"参数 =====  %@",param);
    [SVProgressHUD show];
    [NetController httpConnectionWithRequest:2 URL:path params:param success:success fail:fail];
}

///post请求
+(void)httpRequestWithPath:(NSString *)path success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{

    if(!path || path.length == 0)return;
    [SVProgressHUD show];
    [NetController httpConnectionWithRequest:2 URL:path params:nil success:success fail:fail];
}

#pragma mark 上传照片
///上传照片接口
+(void)uploadImageWithArray:(NSMutableArray *)imageArray parameter:(NSDictionary *)parameter success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{
    [SVProgressHUD show];

    UIImage *image = imageArray[0];
    //组合成url
//    NSString *str=[NSString stringWithFormat:@"time=%@",[xzUtils toTimeTemp]];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",BaseUrl,API_MODIFY_USER_HEAD];

    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];


    NSURLSessionTask *sessionTask=[manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        ///压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        //制定名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *name = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName=[NSString stringWithFormat:@"%@.jpg", name];

        if(imageData){

            [formData appendPartWithFileData:imageData name:@"myfile" fileName:imageFileName mimeType:@"image/jpeg"];
        }
        // 上传图片，以文件流的格式
//        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {

//        typedef void( ^ LXUploadProgress)(int64_t bytesProgress,
//                                          int64_t totalBytesProgress);
//
//        typedef void( ^ LXDownloadProgress)(int64_t bytesProgress,
//                                            int64_t totalBytesProgress);
//        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
//        if (progress) {
//            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        [SVProgressHUD dismiss];
        if (success) {
            success(responseObject);
        }

        [[self tasks] removeObject:sessionTask];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
            [SVProgressHUD dismiss];

        }

        [[self tasks] removeObject:sessionTask];
    }];

    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }


    [sessionTask resume];

}

#pragma mark 上传照片1
///上传照片接口1
+(void)uploadImageWithImage:(UIImage *)iamges parameter:(NSDictionary *)parameter success:(void(^)(id response)) success fail:(void(^) (NSError *error))fail
{
    [SVProgressHUD show];

    //组合成url
    //    NSString *str=[NSString stringWithFormat:@"time=%@",[xzUtils toTimeTemp]];

    NSString *url=[NSString stringWithFormat:@"%@cnpcms/uploadfeedimg",BaseUrl];
    if (!parameter) {
        parameter=[NSDictionary dictionaryWithObjectsAndKeys:[userModel getInstance].userId,@"userId", nil];
    }
    //检查地址中是否有中文
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];


    NSURLSessionTask *sessionTask=[manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        ///压缩图片
        NSData *imageData = UIImageJPEGRepresentation(iamges, 0.5);
        //制定名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *name = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName=[NSString stringWithFormat:@"%@.jpg", name];

        if(imageData){

            [formData appendPartWithFileData:imageData name:@"myfile" fileName:imageFileName mimeType:@"image/jpeg"];
        }
        // 上传图片，以文件流的格式
        //        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {

        //        typedef void( ^ LXUploadProgress)(int64_t bytesProgress,
        //                                          int64_t totalBytesProgress);
        //
        //        typedef void( ^ LXDownloadProgress)(int64_t bytesProgress,
        //                                            int64_t totalBytesProgress);
        //        DLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        //        if (progress) {
        //            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        //        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"上传图片成功=%@",responseObject);
        [SVProgressHUD dismiss];
        if (success) {
            success(responseObject);
        }

        [[self tasks] removeObject:sessionTask];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error=%@",error);
        if (fail) {
            fail(error);
            [SVProgressHUD dismiss];

        }

        [[self tasks] removeObject:sessionTask];
    }];

    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }


    [sessionTask resume];

}

///针对baseUrl地址有问题的
+(void)postRequestWithURL:(NSString *)url content:(NSString *)text 
{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BaseUrl,url];
    //检查地址中是否有中文
    NSString *strUrl=[NSURL URLWithString:urlStr]?urlStr:[self strUTF8Encoding:urlStr];
    AFHTTPSessionManager *manager=[self getAFManager];
    NSDictionary *dic=[NSDictionary dictionaryWithObject:text forKey:@"goodsContent"];
    

    NSURLSessionTask *sessionTask=[manager POST:strUrl parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {


    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        DLog(@"请求结果是＝%@",responseObject);

        [[self tasks] removeObject:sessionTask];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        DLog(@"请求结果是＝%@",error);
        [[self tasks] removeObject:sessionTask];
    }];
    [[self tasks] removeObject:sessionTask];


    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    //运行异步网络程序
    [sessionTask resume];

}

//
+(NSURLSessionTask *)httpConnectionWithRequest:(NSUInteger) type
                                           URL:(NSString *)url
                                        params:(NSDictionary *)params
                                       success:(void(^)(id response))success
                                          fail:(void(^)(NSError *error))fail
{
    DLog(@"请求地址----%@\n    请求参数----%@",url,params);
    if (url==nil) {
        return nil;
    }
    
    //强制转换为utf-8编码
    NSString *Url;
    if ([url containsString:@":"]) {
        Url=[NSString stringWithFormat:@"%@",url];
    }else{
        Url=[NSString stringWithFormat:@"%@%@",BaseUrl,url];
    }
    NSLog(@"%@",Url);
    NSString *urlStr=[Url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPSessionManager *manager=[self getAFManager];
    NSURLSessionTask *sessionTask=nil;

    if (type==1) {
        sessionTask =[manager GET:urlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];

//            DLog(@"请求结果是＝%@",responseObject);
            if (success) {
                success(responseObject);
            }
            [[self tasks] removeObject:sessionTask];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
            DLog(@"error=%@",error);
            if (fail) {
                fail(error);
            }

            [[self tasks] removeObject:sessionTask];
            
            [SVProgressHUD showErrorWithStatus:@"请检查网络是否畅通，app暂时没有网络支持"];
        }];
    }
    else
    {
        sessionTask=[manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            DLog(@"请求成功=%@",responseObject);
            [SVProgressHUD dismiss];

            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DLog(@"error=%@",error);
            [SVProgressHUD dismiss];

            if (fail) {
                fail(error);
            }
            [[self tasks] removeObject:sessionTask];
            
            [SVProgressHUD showErrorWithStatus:@"请检查网络是否畅通，app暂时没有网络支持"];
        }];
    }

    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    //运行异步网络程序
    [sessionTask resume];

    return sessionTask;
}

+(AFHTTPSessionManager *)getAFManager{

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];

    return manager;
    
}
///修改编码
+(NSString *)strUTF8Encoding:(NSString *)str{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
