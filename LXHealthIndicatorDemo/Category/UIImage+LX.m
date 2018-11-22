//
//  UIImage+LX.m
//  HZGAPP
//
//  Created by LX Zeng on 16/8/25.
//  Copyright © 2016   https://github.com/nick8brown   All rights reserved.
//

#import "UIImage+LX.h"

@implementation UIImage (LX)

+ (UIImage *)getImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
