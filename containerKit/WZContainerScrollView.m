//
//  WZContainerScrollView.m
//  WZContainer
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 wzxing55. All rights reserved.
//

#import "WZContainerScrollView.h"
#import "UIView+WZCore.h"


@interface WZContainerScrollView ()

@property(nonatomic, strong) NSMutableOrderedSet *middleViewArrays;
@property(nonatomic) BOOL layoutingSubViews;
@property(nonatomic) NSInteger middleViewContentHeight;
@end

@implementation WZContainerScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)dealloc {
    [self _detachMiddleViews];
}

- (NSMutableOrderedSet *)middleViewArrays {
    if (!_middleViewArrays) {
        _middleViewArrays = [NSMutableOrderedSet orderedSet];
    }
    return _middleViewArrays;
}

- (void)addOneElememtScrollView:(UIScrollView *)elementView {
    if (elementView) {
        [self.middleViewArrays addObject:elementView];
        elementView.scrollEnabled = NO;
        [self addSubview:elementView];
        if (elementView.contentSize.height > elementView.frame.size.height) {
            if (elementView.contentSize.height > self.frame.size.height) {
                elementView.wz_height = self.frame.size.height;
            } else {
                elementView.wz_height = elementView.contentSize.height;
            }
        }
        
        [elementView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|
         NSKeyValueObservingOptionOld context:nil];
    
        [self syncContentSizes];
    }
}

- (void)addOneElememtNativeView:(UIView *)elementView {
    if (elementView) {
        [self.middleViewArrays addObject:elementView];
        [self addSubview:elementView];
        [self syncContentSizes];
    }
}

- (void)addOneElememtView:(UIView<WZContainerElemenProtocol> *)elementView {
    if (elementView) {
        [self.middleViewArrays addObject:elementView];
        elementView.containerDelegate = self;
        
        [self addSubview:elementView];
        [self syncContentSizes];
    }
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    [self syncContentSizes];
}

- (void)setAlpha:(CGFloat)alpha {
    [super setAlpha:alpha];
    [self syncContentSizes];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentSize"] && object && [object isKindOfClass:[UIScrollView class]]){
        
        
        CGSize oldSize = CGSizeZero;
        CGSize newSize = CGSizeZero;
        NSValue* newValue = (NSValue*)[change valueForKey:@"new"];
        NSValue* oldValue  = (NSValue*) [change valueForKey:@"old"];
        if(newValue && oldValue){
            oldSize = oldValue.CGSizeValue;
            newSize = newValue.CGSizeValue;
        }
        
        if (!CGSizeEqualToSize(oldSize, newSize)) {
            UIScrollView* elementView = (UIScrollView*)object;
            if (elementView.contentSize.height > elementView.wz_height) {
                if (elementView.contentSize.height > self.wz_height) {
                    elementView.wz_height = self.wz_height;
                } else {
                    elementView.wz_height = elementView.contentSize.height;
                }
            } else {
                elementView.wz_height = elementView.contentSize.height;
            }
            [self syncContentSizes];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - JRDetailContainerProtocol
- (void)updateElementPosition:(UIView<WZContainerElemenProtocol> *)element {
    if ([self.middleViewArrays containsObject:element]) {
        [self syncContentSizes];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    self.layoutingSubViews = YES;
    
    [super layoutSubviews];

   // [self _computeTableViewY:&tableViewY tableViewOffsetY:&tableViewOffsetY];
    
    [self _updateElementViewFrame];
    

    self.layoutingSubViews = NO;
}

- (void)syncContentSizes {
    
    self.middleViewContentHeight = [self getAllElemetHeight];
    self.contentSize = CGSizeMake(self.wz_width, self.middleViewContentHeight);
    
    [self wz_layoutSubviewsImmediately];
}

- (CGFloat)getAllElemetHeight {
    CGFloat allElemetHeight = 0;
    if ([self.middleViewArrays count]) {
        for (UIView *elememt in self.middleViewArrays) {
            if ([elememt isKindOfClass:[UIScrollView class]]) {
                
                UIScrollView *temp = (UIScrollView*)elememt;
                allElemetHeight += MAX(temp.contentSize.height, temp.wz_height);
                
            } else {
                allElemetHeight += elememt.wz_height;
            }
        }
    }
    return allElemetHeight;
}

#pragma mark - Private methods
- (void)_updateElementViewFrame {
    
    if ([self.middleViewArrays count] > 0) {
        CGFloat height = 0;
        
        const CGFloat contentOffsetY = self.contentOffset.y;
        const CGFloat screenHeight = self.wz_height;
        for (UIView *element in self.middleViewArrays) {
            
            if ([element isKindOfClass:[UIScrollView class]]) {
                
                UIScrollView *scroll = (UIScrollView*)element;
                /*
                 * 配置scroll 高度与屏幕高度一致
                 */
                if (scroll.contentSize.height > scroll.wz_height) {
                    if (scroll.contentSize.height > self.wz_height) {
                        scroll.wz_height = self.wz_height;
                    } else {
                        scroll.wz_height = scroll.contentSize.height;
                    }
                }
                const CGFloat elementHeight = scroll.wz_height;
                
                if (scroll.contentSize.height > elementHeight && scroll.wz_height == screenHeight) {
                    
                    CGFloat visibleHeight = contentOffsetY + screenHeight;
                    const CGFloat maxOffset = scroll.contentSize.height - elementHeight;
                    
                    if (height > visibleHeight) {
                        //不可见
                        scroll.wz_top = height;
                        scroll.contentOffset = CGPointMake(0, 0);
                    } else {
                        //可见
                        CGFloat offset = contentOffsetY - height;
                        
                        if (height > contentOffsetY) {
                            // scroll 部分在可见区域
                            scroll.wz_top = height;
                            scroll.contentOffset = CGPointMake(0, 0);
                        } else if (height <= contentOffsetY) {
                            
                            if (offset < maxOffset) {
                                scroll.wz_top = contentOffsetY;
                                
                                scroll.contentOffset = CGPointMake(0, contentOffsetY - height);
                            } else {
                                scroll.wz_top = height + maxOffset;
                                scroll.contentOffset = CGPointMake(0, maxOffset);
                            }
                        }
                        height += scroll.contentSize.height;
                    }
                } else {
                    element.wz_top = height;
                    height += element.wz_height;
                }
            } else {
                element.wz_top = height;
                height += element.wz_height;
            }
        }
    }
}




- (void)_detachMiddleViews {
    if ([self.middleViewArrays count] > 0) {
        for (UIView *element in self.middleViewArrays) {
            if ([element isKindOfClass:[UIScrollView class]]) {
                [element removeObserver:self forKeyPath:@"contentSize" context:nil];
            } else {
                if ([element conformsToProtocol:@protocol(WZContainerElemenProtocol)]) {
                    UIView<WZContainerElemenProtocol> *elementTemp = (UIView<WZContainerElemenProtocol> *)element;
                    elementTemp.containerDelegate = nil;
                }
            }
            [element removeFromSuperview];
        }
    }
    [self.middleViewArrays removeAllObjects];
    _middleViewArrays = nil;
}
@end
