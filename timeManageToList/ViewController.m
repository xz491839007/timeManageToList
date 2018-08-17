//
//  ViewController.m
//  timeManageToList
//
//  Created by mac on 2017/8/29.
//  Copyright © 2017年 com.xz.timeManageToList. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+YYAdd.h"
#import "GetCiBaApi.h"
#import "YTKNetworkConfig.h"

#import "Ciba.h"
#import "NSObject+YYModel.h"

#import "GetBingImgApi.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    ///词霸的实体类
    Ciba *ci;
    ///是否翻译
    BOOL isTranslt;
    AVAudioPlayer *player;
}

@property (weak, nonatomic) IBOutlet UIImageView *backImagView;
///开始专注按钮
@property (weak, nonatomic) IBOutlet UIButton *BeginBtu;
///开始专注的事件
- (IBAction)startWorking:(UIButton *)sender;
///名言按钮
- (IBAction)meanAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *mingBtu;

@end


@implementation ViewController
///加载界面
-(void)initView{
    /*
     self.sendXYbtu.layer.cornerRadius = 5;
     //设置颜色
     self.sendXYbtu.layer.borderColor = navColor.CGColor;
     self.sendXYbtu.layer.borderWidth = 1;
     */
    ///开始按钮
    self.BeginBtu.layer.cornerRadius=20;
//    self.BeginBtu.layer.borderColor=RGBAlpha(205, 10, 32, 1).CGColor;
    self.BeginBtu.layer.borderColor=[UIColor whiteColor].CGColor;

    self.BeginBtu.layer.borderWidth=1;
    self.mingBtu.titleLabel.lineBreakMode=0;
    self.mingBtu.selected=NO;
    isTranslt=NO;
}




-(void)viewWillAppear:(BOOL)animated{
    ///初始化界面
    [self initView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化时间
    nowDate =[NSDate date];
    timeInterval=25;


    ///街霸
    ///词霸的开放地址http://open.iciba.com/dsapi/
    GetCiBaApi *ciba=[[GetCiBaApi alloc] init];
    [ciba startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict=request.responseObject;
        ci=[Ciba modelWithDictionary:dict];
        [self.mingBtu setTitle:ci.content forState:UIControlStateNormal];
        NSLog(@"%@",ci.content);

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"error:%@",request.error);
    }];

    ///bing的图片
    GetBingImgApi *bingImg=[[GetBingImgApi alloc] init];
    [bingImg startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -清除缓存
- (void)clearTmpPics

{
//    [[SDImageCache sharedImageCache] clearDisk];
    ///清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
}

///翻译的事件
- (IBAction)meanAction:(UIButton *)sender {
    isTranslt=!isTranslt;
    if (isTranslt) {
        ///翻译汉语状态
        [sender setTitle:ci.note forState:UIControlStateNormal];
    }
    else{
        [sender setTitle:ci.content forState:UIControlStateNormal];

    }

}



- (IBAction)startWorking:(UIButton *)sender {
    [self startLocation];

}

///设置真后台模式
-(void)startLocation{

    //设置后台模式和锁屏模式下依然能够播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];

    //初始化音频播放器
    NSError *playerError;
    NSURL *urlSound = [[NSURL alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"jingYing" ofType:@"mp3"]];
    AVAudioPlayer *playerSound = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:&playerError];
    playerSound.numberOfLoops = -1;//无限播放
    player = playerSound;
    [player play];

}


@end
