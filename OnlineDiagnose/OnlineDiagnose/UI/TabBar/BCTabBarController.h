//
//  QZoneTabBarController.h
//  QZone
//
//  Created by AllenMa on 15-3-13.
//  Copyright (c) 2015年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTabBarItem.h"

#define QZoneTabBarHeight 49
#define QZoneTabBarNewBackgroundHeight 55


@interface BCTabBarController : UITabBarController

@property (nonatomic, strong) BCTabBarCenterItem *centerItem;

@property (strong, nonatomic) UIImageView *bgImageView;

@end

