//
//Created by ESJsonFormatForMac on 17/08/29.
//

#import <Foundation/Foundation.h>

@class CibaTag;


@interface Ciba : NSObject
///英语
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *caption;
///翻译
@property (nonatomic, copy) NSString *note;

@property (nonatomic, copy) NSString *translation;

@property (nonatomic, copy) NSString *picture2;

@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSString *s_pv;

@property (nonatomic, copy) NSString *sp_pv;

//@property (nonatomic, strong) NSArray<CibaTag *> *tags;

@property (nonatomic, copy) NSString *love;
///一个图片
@property (nonatomic, copy) NSString *fenxiang_img;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *tts;

@end


@interface CibaTag : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *name;

@end

