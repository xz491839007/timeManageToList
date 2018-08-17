//
//  GetBingImgApi.m
//  timeManageToList
//
//  Created by mac on 2017/9/6.
//  Copyright © 2017年 com.xz.timeManageToList. All rights reserved.
//

#import "GetBingImgApi.h"

@implementation GetBingImgApi

- (id)initWithTxt{
    self=[super init];
    if (self) {

    }
    return self;
}

/*
 1. 访问 https://api.ioliu.cn/bing/ , 返回bing每日最新背景图, 可选参数[w,h]
 2. 访问 https://api.ioliu.cn/bing/?d=n (n>=0), 返回以当日为起点第n天前的壁纸, 可选参数[w,h]
 3. 访问 https://api.ioliu.cn/bing/json/ , 返回bing每日最新壁纸的相关(介绍、图片地址等)信息(json格式), 可选参数[callback].
 4. 访问 https://api.ioliu.cn/bing/rand/ , 返回随机图片, 可选参数[w,h]
 5. 访问 https://api.ioliu.cn/bing/blur/ , 返回高斯模糊图片, 可选参数[d,w,h]
 带[w,h]用法： https://api.ioliu.cn/bing/rand/?w=1920&h=1200
 http:bing.ioliu.cn/v1/blur?w=768&h=1280&r=20
 目前已知图片分辨率
 1920x1200   1920x1080    1366x768   1280x768
 1024x768    800x600       800x480   768x1280
 720x1280    640x480       480x800   400x240
 320x240     240x320

 */

- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return URL_BINGIMAGE;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

/*
 GetCiBaApi *ciba=[[GetCiBaApi alloc] init];
 [ciba startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
 NSDictionary *dict=request.responseObject;
 NSArray *arr=[dict objectForKey:@"images"];
 if(arr.count!=0){
 NSDictionary *dict_1=arr[0];
 NSString *url=[dict_1 stringValueForKey:@"url" default:nil];
 ///拼接以及处理字符串
 NSString *imgUrl=[url substringToIndex:(url.length-13)];

 NSString * img_url=[NSString stringWithFormat:@"%@%@768x1280.jpg",URL_BING,imgUrl];
 [self clearTmpPics];
 [self.backImagView sd_setImageWithURL:[NSURL URLWithString:img_url]];


 }

 } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
 NSLog(@"error:%@",request.error);
 }];

 */


@end
