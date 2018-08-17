//
//  UILabel+VericalAlign.m
//  BNBAccounting
//
//  Created by mark.z on 14/11/24.
//  Copyright (c) 2014年 mark.z. All rights reserved.
//

#import "UILabel+VericalAlign.h"

@implementation UILabel (VericalAlign)


- (void)adaptiveHeight
{
  CGSize maximumSize =CGSizeMake(290,9999);
  NSString*dateString = self.text;

  UIFont*dateFont =[UIFont fontWithName:@"HelveticaNeue-Thin" size:15.0f];
  
//  NSDictionary *dict1 = @{NSFontAttributeName:dateFont.fontName};
//  
//  CGRect dateStringSize = [self.text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict1 context:nil];
  
  CGSize dateStringSize =[dateString sizeWithFont:dateFont
                                constrainedToSize:maximumSize
                                    lineBreakMode:NSLineBreakByCharWrapping];
  self.numberOfLines = 0;
  CGRect frame = self.frame;
  
  frame.size.height = dateStringSize.height + 10;
  
  self.frame = frame;
}

-(void)alignTop {

  NSDictionary *dict = @{NSFontAttributeName:self.font.fontName};
  CGSize fontSize = [self.text sizeWithAttributes:dict];
  
  double finalHeight = fontSize.height *self.numberOfLines;
  double finalWidth =self.frame.size.width;//expected width of label
//  CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
  
  NSDictionary *dict1 = @{NSFontAttributeName:self.font.fontName};
  
  CGRect theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict1 context:nil];
  
  int newLinesToPad =(finalHeight - theStringSize.size.height)/ fontSize.height;
  for(int i=0; i<newLinesToPad; i++)
    self.text =[self.text stringByAppendingString:@"\n "];
}

-(void)alignBottom {
  
  NSDictionary *dict = @{NSFontAttributeName:self.font.fontName};
  CGSize fontSize = [self.text sizeWithAttributes:dict];
  
  double finalHeight = fontSize.height *self.numberOfLines;
  double finalWidth =self.frame.size.width;//expected width of label
  

  CGRect theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
  int newLinesToPad =(finalHeight - theStringSize.size.height)/ fontSize.height;
  for(int i=0; i<newLinesToPad; i++)
    self.text =[NSString stringWithFormat:@" \n%@",self.text];
}
@end
