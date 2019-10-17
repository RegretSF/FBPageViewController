//
//  UIView+FBExtension.h
//  PageView
//
//  Created by Mac on 2019/10/14.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FBExtension)
// 推荐：CGFloat x = CGRectGetMinX(frame);
@property (nonatomic, assign) CGFloat cs_x;
// 推荐：CGFloat y = CGRectGetMinY(frame);
@property (nonatomic, assign) CGFloat cs_y;

@property (nonatomic, assign) CGFloat cs_maxX;
@property (nonatomic, assign) CGFloat cs_maxY;

@property (nonatomic, assign) CGFloat cs_centerX;
@property (nonatomic, assign) CGFloat cs_centerY;

// 推荐：CGFloat width = CGRectGetWidth(frame);
@property (nonatomic, assign) CGFloat cs_width;
// 推荐：CGFloat height = CGRectGetHeight(frame);
@property (nonatomic, assign) CGFloat cs_height;

@property (nonatomic, assign) CGSize cs_size;
@property (nonatomic, assign) CGPoint cs_origin;
@property (nonatomic, assign) CGFloat cs_bottom;
@end

NS_ASSUME_NONNULL_END
