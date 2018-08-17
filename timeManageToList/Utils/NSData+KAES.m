//
//  NSData+AES.m
//  SecurityiOS
//
//  Created by mac on 2017/2/28.
//  Copyright © 2017年 dev.keke@gmail.com. All rights reserved.
//

#import "NSData+KAES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (KAES)

- (NSData *)AES_ECB_EncryptWith:(NSData *)key
{
    NSData *retData = nil;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          key.bytes, key.length,
                                          NULL,
                                          self.bytes, self.length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        retData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return retData;
}

- (NSData *)AES_ECB_DecryptWith:(NSData *)key
{
    NSData *retData = nil;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    bzero(buffer, bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          key.bytes, key.length,
                                          NULL,
                                          self.bytes, self.length,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        retData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return retData;
}


@end
