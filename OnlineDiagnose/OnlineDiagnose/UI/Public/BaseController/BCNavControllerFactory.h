//
//  QZNavFactoryManager.h
//  QZone
//
//  Created by AllenMa on 15-3-12.
//  Copyright 2015 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

/***********************************************************
 *
 * 所有程序中使用的NavigationController都由这里创建，方便后续管理
 *
 ***********************************************************/
@interface BCNavControllerFactory : NSObject

+ (UINavigationController *)navigationControllerWithRootController:(UIViewController *)rootController;

@end
