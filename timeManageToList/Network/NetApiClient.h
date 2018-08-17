//
//  NetApiClient.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFHTTPClient.h"
#import "AFHTTPSessionManager.h"
@interface NetApiClient : AFHTTPSessionManager

+ (NetApiClient *)sharedClient;

+ (void)destory;

@end
