//
//  CircleProgressBar.m
//  timeManageToList
//
//  Created by mac on 2017/9/6.
//  Copyright © 2017年 com.xz.timeManageToList. All rights reserved.
//

#import "CircleProgressBar.h"

// Common
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)



@implementation CircleProgressBar

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);

    CGContextBeginPath(context);
    ///NO是顺时针
    CGContextAddArc(context,self.width/2 , self.height/2, self.width/2-1, DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), NO);
//    ///Yes是逆时针
    CGContextAddArc(context,self.width/2 , self.height/2, self.width/2-4, DEGREES_TO_RADIANS(360), DEGREES_TO_RADIANS(0), YES);

    CGContextClosePath(context);
    CGContextFillPath(context);
    ///填充
    CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
    CGContextBeginPath(context);
    CGContextAddArc(context, self.width/2, self.height/2,self.width/2-1, DEGREES_TO_RADIANS(40), DEGREES_TO_RADIANS(360), NO);
    CGContextAddArc(context,self.width/2, self.height/2, self.width/2-4, DEGREES_TO_RADIANS(360), DEGREES_TO_RADIANS(40), YES);
    CGContextClosePath(context);
    CGContextFillPath(context);

}


/*
    ///描绘2维
 ///获得图形上下文
 CGContextRef context = UIGraphicsGetCurrentContext();
 ///移动坐标到75，10
 CGContextMoveToPoint (context,0,0);
 ///添加坐标位移
 CGContextAddLineToPoint(context, 20, 0);
 CGContextAddLineToPoint(context, 20, 20);
 // Closing the path connects the current point to the start of the current path.
 ///结束位移
 CGContextClosePath(context);
 // And stroke the path
 ///描边的颜色
 [[UIColor blackColor] setStroke];
 //CGContextStrokePath(context);
 ///充满的颜色
 [[UIColor redColor] setFill];
 CGContextDrawPath(context, kCGPathFillStroke);
 //kCGPathFillStroke,kCGPathFill,kCGPathStroke

 */

@end
