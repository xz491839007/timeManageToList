//
//  UILabel+LSLabelSize.h
//
//  Created by liushuai on 16/3/30.
//  Copyright © 2016年 liushuai1992@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (LSLabelSize)

/**
 *  @author liushuai1992@gmail.com, 2016-03
 *
 *  @brief Calculate the height according to the text attribute
 *  给定label宽度、字号和文字，计算label高度。
 *
 *  @param string   the text has given 给定的文字
 *  @param fontSize the font's size 字号大小
 *  @param width    the label's width label宽度
 *
 *  @return the height of label label的高度
 */
+ (CGFloat)heightOfLabelWithString:(NSString *)string sizeOfFont:(CGFloat)fontSize width:(CGFloat)width;



/**
 *  @author liushuai1992@gmail.com, 2016-03
 *
 *  @brief Calculate the height according to the text attribute 给定label宽度和留白，字号、文字，计算label高度。
 *
 *  @param string   the text has given 给定的文字
 *  @param fontSize the font's size 字号大小
 *  @param width    the label's width label宽度
 *  @param edge     the blank size for label's top, left, bottom, right label的上、左、下、右空白大小
 *
 *  @return the height of label label的高度
 */
+ (CGFloat)heightOfLabelWithString:(NSString *)string sizeOfFont:(CGFloat)fontSize width:(CGFloat)width edge:(UIEdgeInsets)edge;

/**
 *  @author liushuai1992@gmail.com, 2016-03
 *
 *  @brief Calculate the height according to the text attribute 给定label宽度和留白，字号、文字，计算label高度。按照PINGFANG字体来计算
 *
 *  @param string   the text has given 给定的文字
 *  @param fontSize the font's size 字号大小
 *  @param width    the label's width label宽度
 *
 *  @return the height of label label的高度
 */

+ (CGFloat)heightOfLabelWithStringIsPINGFANG:(NSString *)string sizeOfFont:(CGFloat)fontSize width:(CGFloat)width;

/**
 *  @author liushuai1992@gmail.com, 2016-03
 *
 *  @brief Calculate the width according to the text attribute
 *  给定label的高度，文字内容和字号大小，计算label的宽度
 *
 *  @param string   the text has given 自定的文字
 *  @param fontSize the font's size 字号的大小
 *  @param height   the label's height labe的高度
 *
 *  @return the width of label lable的宽度
 */
+ (CGFloat)widthOfLabelWithString:(NSString *)string sizeOfFont:(CGFloat)fontSize height:(CGFloat)height;



/**
 *  @author liushuai1992@gmail.com, 2016-03
 *
 *  @brief Calculate the width according to the text attribute
 *
 *  @param string   the text has given 自定的文字
 *  @param fontSize the font's size 字号的大小
 *  @param height   the label's height labe的高度
 *  @param edge     the blank size for label's top, left, bottom, right label的上、左、下、右空白大小
 *
 *  @return the width of label lable的宽度
 */
+ (CGFloat)widthOfLabelWithString:(NSString *)string sizeOfFont:(CGFloat)fontSize height:(CGFloat)height edge:(UIEdgeInsets)edge;


@end
