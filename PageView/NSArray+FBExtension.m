//
//  NSArray+FBExtension.m
//  PageView
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "NSArray+FBExtension.h"
#import <UIKit/UIKit.h>

@implementation NSArray (FBExtension)
// 将UIColor转换为RGB值
+ (NSArray<NSNumber *> *)arrayToRGBWithColor:(UIColor *)color {
    CGFloat r = 0.0, g = 0.0, b = 0.0;
    NSInteger numComponents = CGColorGetNumberOfComponents(color.CGColor);
    if (numComponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        r = components[0] * 255;
        g = components[1] * 255;
        b = components[2] * 255;
    }
    NSMutableArray *arrayM = [NSMutableArray arrayWithObjects:[NSNumber numberWithFloat:r],
                                                              [NSNumber numberWithFloat:g],
                                                              [NSNumber numberWithFloat:b],
                                                              nil];
    return arrayM;
}

@end
