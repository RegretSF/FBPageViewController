//
//  UIColor+FBExtension.h
//
//  Created on 2019/8/19.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 颜色r.g.b方法
#define FBRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface UIColor (FBExtension)
/// 随机颜色
+ (UIColor *)randomColor;

/// 颜色RGB值
/// @param r red
/// @param g green
/// @param b blue
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

/// 十六进制数值转换为UIColor
/// @param hex 颜色16进制数值
+ (UIColor *)colorWithHex:(int)hex;

/// 十六进制颜色转化为UIColor
/// @param hexString hexString 16进制字符串（可以以0x开头，可以以#开头，也可以就是6位的16进制）
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/// 适配 UIColor 浅色模式和暗黑模式的颜色，不管是iOS几都可以使用此方法
/// @param lightColor 浅色模式的颜色
/// @param darkColor 暗黑模式的颜色
+ (UIColor *)colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
