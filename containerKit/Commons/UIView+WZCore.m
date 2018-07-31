//
//  UIView+WZCore.m
//  WZContainer
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 wzxing55. All rights reserved.
//

#import "UIView+WZCore.h"

@implementation UIView (WZCore)

- (CGFloat)wz_left {
    return self.frame.origin.x;
}

- (void)setWz_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)wz_top {
    return self.frame.origin.y;
}

- (void)setWz_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)wz_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWz_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)wz_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setWz_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)wz_centerX {
    return self.center.x;
}

- (void)setWz_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)wz_centerY {
    return self.center.y;
}

- (void)setWz_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)wz_innerCenter {
    return CGPointMake(self.wz_boundsWidth / 2, self.wz_boundsHeight / 2);
}

- (CGFloat)wz_width {
    return self.frame.size.width;
}

- (void)setWz_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)wz_height {
    return self.frame.size.height;
}

- (void)setWz_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)wz_origin {
    return self.frame.origin;
}

- (void)setWz_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)wz_size {
    return self.frame.size;
}

- (void)setWz_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)wz_boundsHeight {
    return self.bounds.size.height;
}

- (CGFloat)wz_boundsWidth {
    return self.bounds.size.width;
}


/**
 * invoke layoutSubview in this runloop
 */
- (void)wz_layoutSubviewsImmediately {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
