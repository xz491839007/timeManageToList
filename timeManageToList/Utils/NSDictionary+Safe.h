//
//  NSDictionary+Safe.h
//  LINK
//
//  Created by mark on 15/11/23.
//  Copyright © 2015年 LINK. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (LinkSafe)

- (BOOL)hasKey:(NSString *)key;

-(NSString *)stringForKeyX:(id)key;

- (NSNumber*)numberForKeyX:(id)key;

- (NSArray*)arrayForKeyX:(id)key;

- (NSDictionary*)dictionaryForKeyX:(id)key;

- (NSInteger)integerForKeyX:(id)key;

- (NSUInteger)unsignedIntegerForKeyX:(id)key;

- (BOOL)boolForKeyX:(id)key;

- (short)shortForKeyX:(id)key;

- (float)floatForKeyX:(id)key;

- (double)doubleForKeyX:(id)key;

- (NSDate *)dateForKeyX:(id)key dateFormat:(NSString *)dateFormat;

@end