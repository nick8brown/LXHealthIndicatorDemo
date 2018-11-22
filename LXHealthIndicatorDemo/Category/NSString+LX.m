//
//  NSString+LX.m
//  HZGAPP
//
//  Created by LX Zeng on 16/5/16.
//  Copyright © 2016   https://github.com/nick8brown   All rights reserved.
//

#import "NSString+LX.h"

@implementation NSString (LX)

// 字符串拼接符号
+ (NSString *)configLabelWithData:(NSArray *)data appendString:(NSString *)appendString {
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    int index = 0;
    for (int i = 0; i < data.count; i++) {
        NSString *str = data[i];
        if (![str isEqualToString:@""]) {
            index = i;
            break;
        }
    }
    for (int i = index; i < data.count; i++) {
        NSString *str = data[i];
        if (![str isEqualToString:@""]) {
            if (![mStr isEqualToString:@""]) {
                [mStr appendString:appendString];
            }
            [mStr appendString:str];
        }
    }
    return mStr;
}

// 字符串分割符号
+ (NSString *)separateString:(NSString *)str separator:(NSString *)separator {
    NSMutableString *mStr = [NSMutableString stringWithString:str];
    return [NSString configLabelWithData:[mStr componentsSeparatedByString:separator] appendString:@""];
}

// 字符串替换符号
+ (NSString *)replaceString:(NSString *)str target:(NSString *)target replacement:(NSString *)replacement {
    NSMutableString *mStr = [NSMutableString stringWithString:str];
    return [mStr stringByReplacingOccurrencesOfString:target withString:replacement];
}

// 字符串截取
+ (NSString *)substring:(NSString *)str FromIndex:(NSUInteger)from {
    NSString *mStr = [NSMutableString stringWithString:str];
    mStr = [mStr substringFromIndex:from];
    return mStr;
}

+ (NSString *)substring:(NSString *)str ToIndex:(NSUInteger)to {
    NSString *mStr = [NSMutableString stringWithString:str];
    mStr = [mStr substringToIndex:to];
    return mStr;
}

+ (NSString *)substring:(NSString *)str WithRange:(NSRange)range {
    NSString *mStr = [NSMutableString stringWithString:str];
    mStr = [mStr substringWithRange:range];
    return mStr;
}

#pragma mark - 得到格式化当前时间
+ (NSString *)getCurrentTimeWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate *)getCurrentDateWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]];
}

@end
