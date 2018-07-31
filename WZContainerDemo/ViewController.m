//
//  ViewController.m
//  WZContainerDemo
//
//  Created by viczxwang on 2018/7/20.
//  Copyright © 2018年 threeNanguoPear. All rights reserved.
//

#import "ViewController.h"
#import <WZContainer/WZContainer.h>
#import <WZContainer/WZContainerScrollView.h>


@interface WZTestScrollView:UIScrollView
@end;

@implementation WZTestScrollView



@end;


@interface ViewController ()
@property(nonatomic,strong) WZContainerScrollView* containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if(!_containerView){
        _containerView = [[WZContainerScrollView alloc] initWithFrame:self.view.bounds];
    }
    
    UIView* one =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    one.backgroundColor = [UIColor whiteColor];
    [self.containerView addOneElememtNativeView:one];
    
    
    
    UIView* two =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
    two.backgroundColor = [UIColor grayColor];
    [self.containerView addOneElememtNativeView:two];
  
    
    WZTestScrollView* scrollView =  [[WZTestScrollView  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    scrollView.backgroundColor = [UIColor blueColor];
    
    [self.containerView addOneElememtScrollView:scrollView];
    
    UIView* three =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1100)];
    three.backgroundColor = [UIColor whiteColor];
    [self.containerView addOneElememtNativeView:three];
    
    
    self.containerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.containerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
