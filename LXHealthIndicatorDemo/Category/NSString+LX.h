//
//  NSString+LX.h
//  HZGAPP
//
//  Created by LX Zeng on 16/5/16.
//  Copyright © 2016   https://github.com/nick8brown   All rights reserved.
//

#import <Foundation/Foundation.h>

#define YEAR @"yyyy"
#define YEAR_MONTH @"yyyy-MM"
#define YEAR_MONTH_DAY @"yyyy-MM-dd"
#define YEAR_MONTH_DAY_HOUR_MINUTE @"yyyy-MM-dd HH:mm"
#define YEAR_MONTH_DAY_HOUR_MINUTE_SECOND @"yyyy-MM-dd HH:mm:ss"

@interface NSString (LX)

// 字符串拼接符号
+ (NSString *)configLabelWithData:(NSArray *)data appendString:(NSString *)appendString;
// 字符串分割符号
+ (NSString *)separateString:(NSString *)str separator:(NSString *)separator;
// 字符串替换符号
+ (NSString *)replaceString:(NSString *)str target:(NSString *)target replacement:(NSString *)replacement;

// 字符串截取
+ (NSString *)substring:(NSString *)str FromIndex:(NSUInteger)from;
+ (NSString *)substring:(NSString *)str ToIndex:(NSUInteger)to;
+ (NSString *)substring:(NSString *)str WithRange:(NSRange)range;

// 得到格式化当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat;
+ (NSDate *)getCurrentDateWithDateFormat:(NSString *)dateFormat;

@end
