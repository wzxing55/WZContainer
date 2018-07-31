//
//  UIView+WZCore.h
//  WZContainer
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 wzxing55. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WZCore)
@property(nonatomic /* override */) CGFloat wz_left;

@property(nonatomic /* override */) CGFloat wz_top;

@property(nonatomic /* override */) CGFloat wz_right;

@property(nonatomic /* override */) CGFloat wz_bottom;

@property(nonatomic /* override */) CGFloat wz_width;

@property(nonatomic /* override */) CGFloat wz_height;

@property(nonatomic /* override */) CGFloat wz_centerX;

@property(nonatomic /* override */) CGFloat wz_centerY;

@property(nonatomic /* override */, readonly) CGPoint wz_innerCenter;

@property(nonatomic /* override */) CGPoint wz_origin;

@property(nonatomic /* override */) CGSize wz_size;

@property(nonatomic, readonly) CGFloat wz_boundsWidth;
@property(nonatomic, readonly) CGFloat wz_boundsHeight;

- (void)wz_layoutSubviewsImmediately;
@end
