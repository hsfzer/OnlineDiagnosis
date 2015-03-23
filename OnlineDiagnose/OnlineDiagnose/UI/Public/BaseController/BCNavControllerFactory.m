//
//  QZNavFactoryManager.m
//  QZone
//
//  Created by Dean on 12-2-1.
//  Copyright 2012 tencent. All rights reserved.
//

#import "BCNavControllerFactory.h"
#import "BCBaseNavigationController.h"


@implementation BCNavControllerFactory

+ (UINavigationController *)navigationControllerWithRootController:(UIViewController *)rootController
{
    BCBaseNavigationController *navController = [[BCBaseNavigationController alloc] initWithRootViewController:rootController];
	return navController;
}

@end
