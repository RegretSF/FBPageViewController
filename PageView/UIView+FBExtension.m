//
//  UIView+FBExtension.m
//  PageView
//
//  Created by Mac on 2019/10/14.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "UIView+FBExtension.h"

@implementation UIView (FBExtension)
#pragma mark - x
- (void)setCs_x:(CGFloat)cs_x {
    CGRect frame = self.frame;
    frame.origin.x = cs_x;
    self.frame = frame;
}

- (CGFloat)cs_x {
    return CGRectGetMinX(self.frame);
}

#pragma mark - y
- (void)setCs_y:(CGFloat)cs_y {
    CGRect frame = self.frame;
    frame.origin.y = cs_y;
    self.frame = frame;
}

- (CGFloat)cs_y {
    return CGRectGetMinY(self.frame);
}

#pragma mark - maxX
-(void)setCs_maxX:(CGFloat)cs_maxX {
    self.cs_x = cs_maxX - self.cs_width;
}

- (CGFloat)cs_maxX {
    return CGRectGetMaxX(self.frame);
}

#pragma mark - maxY
- (void)setCs_maxY:(CGFloat)cs_maxY {
    self.cs_y = cs_maxY - self.cs_height;
}

- (CGFloat)cs_maxY {
    return CGRectGetMaxY(self.frame);
}

#pragma mark - centerX
- (void)setCs_centerX:(CGFloat)cs_centerX {
    CGPoint center = self.center;
    center.x = cs_centerX;
    self.center = center;
}

- (CGFloat)cs_centerX {
    return self.center.x;
}

#pragma mark - centerY
- (void)setCs_centerY:(CGFloat)cs_centerY {
    CGPoint center = self.center;
    center.y = cs_centerY;
    self.center = center;
}

- (CGFloat)cs_centerY {
    return self.center.y;
}

#pragma mark - width
- (void)setCs_width:(CGFloat)cs_width {
    CGRect frame = self.frame;
    frame.size.width = cs_width;
    self.frame = frame;
}

- (CGFloat)cs_width {
    return CGRectGetWidth(self.frame);
}

#pragma mark - height
- (void)setCs_height:(CGFloat)cs_height {
    CGRect frame = self.frame;
    frame.size.height = cs_height;
    self.frame = frame;
}

- (CGFloat)cs_height {
    return CGRectGetHeight(self.frame);
}

#pragma mark - size
- (void)setCs_size:(CGSize)cs_size {
    CGRect frame = self.frame;
    frame.size = cs_size;
    self.frame = frame;
}

- (CGSize)cs_size {
    return self.frame.size;
}

#pragma mark - orgin
- (void)setCs_origin:(CGPoint)cs_origin {
    CGRect frame = self.frame;
    frame.origin = cs_origin;
    self.frame = frame;
}

- (CGPoint)cs_origin {
    return self.frame.origin;
}

#pragma mark  - bottom
- (void)setCs_bottom:(CGFloat)cs_bottom {
    CGRect frame = self.frame;
    frame.origin.y = cs_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)cs_bottom {
    CGRect frame = self.frame;
    return CGRectGetMinY(frame) + CGRectGetHeight(frame);
}

@end
