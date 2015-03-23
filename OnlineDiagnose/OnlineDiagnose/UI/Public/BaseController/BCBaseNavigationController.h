//
//  BCBaseNavigationController.h
//  QZone
//
//  Created by Allen Ma on 15-1-12.
//  Copyright 2015 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCBaseNavigationController : UINavigationController

@property(nonatomic, weak) UIViewController	*hk_parent;
@property(nonatomic, assign) BOOL animating;

@end
