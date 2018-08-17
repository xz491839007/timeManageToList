//
//  NSData+AES.h
//  SecurityiOS
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 dev.keke@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSData (KAES)

/**
 AES ecb 模式加密，
 @key 长度16字节，24字节，32字节
 */
- (NSData *)AES_ECB_EncryptWith:(NSData *)key;

/**
 AES ecb 模式解密，
 @key 长度16字节，24字节，32字节
 */
- (NSData *)AES_ECB_DecryptWith:(NSData *)key;


@end

