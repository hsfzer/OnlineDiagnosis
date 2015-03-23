//
//  BCBaseViewController.h
//  QZone
//
//  Created by AllenMa on 15-1-12.
//  Copyright 2015 tencent. All rights reserved.

#import <Foundation/Foundation.h>

/***********************************************************
 *
 * 所有程序中使用的UIViewController的子类都从这个继承，
 * 方便实现一些公共的需求和全局的设置
 *
 ***********************************************************/

typedef enum : NSUInteger {
    viewStateNone,
    viewStateLoaded,
    viewStateAppearing,
    viewStateAppeared,
    viewStateDisappearing,
    viewStateDisappeared,
    viewStateUnloading
} BCViewControllerState;

@interface BCBaseViewController : UIViewController

@property (nonatomic, weak)   UIViewController        *hk_parent;
@property (nonatomic, assign) BCViewControllerState   viewState;
@property (nonatomic, assign) BOOL                    isViewFirstLoad;

@property (nonatomic, assign) BOOL                     animating;

- (void)onPop;

@end
