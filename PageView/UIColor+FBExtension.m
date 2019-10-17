//
//  UIColor+FBExtension.m
//
//  Created on 2019/8/19.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "UIColor+FBExtension.h"

@implementation UIColor (FBExtension)
// 随机颜色
+ (UIColor *)randomColor {
    return [UIColor colorWithR:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256)];
}

// 颜色 RGB 值
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

// 十六进制数值转换为UIColor
+ (UIColor *)colorWithHex:(int)hex {
    float r, g, b;
    b = hex & 0x0000FF;
    hex = hex >> 8;
    g = hex & 0x0000FF;
    hex = hex >> 8;
    r = hex;
    return [UIColor colorWithR:r g:g b:b];
}

// 十六进制颜色转化为UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString * cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString * rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString * gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString * bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b];
}

// 设置浅色模式和暗黑模式的颜色，不管是iOS几都可以使用此方法
+ (UIColor *)colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                return lightColor;
            }else {
                return darkColor;
            }
        }];
        
        return dyColor;
    }else {
        return lightColor;
    }
}


@end
