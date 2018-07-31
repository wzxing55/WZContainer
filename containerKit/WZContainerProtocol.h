//
//  WZContainerProtocol.h
//  WZContainer
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 wzxing55. All rights reserved.
//

#ifndef WZContainerProtocol_h
#define WZContainerProtocol_h

@protocol WZContainerElemenProtocol;

@protocol WZContainerProtocol<NSObject>
- (void)updateElementPosition:(UIView<WZContainerElemenProtocol> *)element;

@optional
- (void)synTableViewOffset:(CGPoint)tableViewOffset animated:(BOOL)animated;
@end

@protocol WZContainerElemenProtocol<NSObject>
@property(nonatomic, weak) id<WZContainerProtocol> containerDelegate;
- (void)shouldUpdateElementPosition;

- (void)reuseElement;
@optional
// 距离上一个控件的距离  不设置为零，如果组件排第一个 则为kJRDetailElementFirstMarginTop
- (CGFloat)marginAboveElement;

// 作为最后一个元素时 距离底部的距离，没有就是0
- (CGFloat)lastMarginBottom;
@end

#endif /* WZContainerProtocol_h */
