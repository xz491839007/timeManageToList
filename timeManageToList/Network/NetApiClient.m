//
//  NetApiClient.h
//  LINK
//
//  Created by mark on 15/10/11.
//  Copyright (c) 2015年 LINK. All rights reserved.
//

#import "NetApiClient.h"

//#import "AFJSONRequestOperation.h"

static NetApiClient *_sharedClient = nil;

@implementation NetApiClient

+ (NetApiClient *)sharedClient {
    if(!_sharedClient){
//        _sharedClient = [[NetApiClient alloc] initWithBaseURL:[NSURL URLWithString:[UserConfig rootUrl]]];
    }
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];//设置请求数据为json
    self.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    self.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    self.requestSerializer.timeoutInterval=10;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];

//    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/x-json", @"text/html",nil]];
//    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
//	[self setDefaultHeader:@"Accept" value:@"application/json"];

    return self;
}

+ (void)destory
{
    _sharedClient = nil;
}
@end
