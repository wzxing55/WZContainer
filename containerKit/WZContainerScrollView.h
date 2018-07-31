//
//  WZContainerScrollView.h
//  WZContainer
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 wzxing55. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WZContainer/WZContainerProtocol.h>

@interface WZContainerScrollView : UIScrollView<WZContainerProtocol>

-(void)addOneElememtNativeView:(UIView *)elementView;
- (void)addOneElememtView:(UIView<WZContainerElemenProtocol> *)elemetView;
- (void)addOneElememtScrollView:(UIScrollView *)elementView;

@end
