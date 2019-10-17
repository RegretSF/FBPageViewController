//
//  NSArray+FBExtension.h
//  PageView
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class UIColor;
@interface NSArray (FBExtension)
/// 将 UIColor 转换为 RGB 值
/// @param color UIColor
+ (NSArray<NSNumber *> *)arrayToRGBWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
