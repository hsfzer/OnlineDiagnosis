//
//  BCBaseNavigationController.m
//  QZone
//
//  Created by AllenMa on 15-3-12.
//  Copyright 2015 tencent. All rights reserved.
//

#import "BCBaseNavigationController.h"
#import "BCBaseViewController.h"
#import "CommonUtils.h"


@interface BCBaseNavigationController ()

@property (weak, nonatomic) UIViewController *popingController;

@end

@implementation BCBaseNavigationController

- (void)designatedInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onBaseNavigationControllerDidEnterBackground:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
}

- (void)doubleTap:(id)sender
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    UIWindow *keyWindow = [(UIApplication *)[UIApplication sharedApplication] keyWindow];
    if ([keyWindow respondsToSelector:@selector(recursiveDescription)]) {
        NSLog(@"%@", [[(UIApplication *)[UIApplication sharedApplication] keyWindow] performSelector:@selector(recursiveDescription) withObject:nil]);
    }
#pragma clang diagnostic pop
}

- (id)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    if (self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass]) {
        [self designatedInit];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self designatedInit];
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.navigationController.topViewController == viewController) {
        NSLog(@"%@ controller(%@) has been pushed.", NSStringFromSelector(_cmd), viewController);
        return;
    }
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        if (((BCBaseViewController *)self.topViewController).animating) {
            NSLog(@"%@ controller(%@) push when animating.", NSStringFromSelector(_cmd), viewController);
            return;
        }
    }
	
    if(!viewController){
        NSLog(@"%@ controller(%@) is nil.", NSStringFromSelector(_cmd), viewController);
        return;
    }
    
    if ([CommonUtils iOS5]) {
        if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
            if (((BCBaseViewController *)self.topViewController).viewState == viewStateAppearing) {
                NSLog(@"iOS 5 %@ controller(%@) push when view appearing.", NSStringFromSelector(_cmd), viewController);
                // return;
            }
        }
    }
    
	if ([viewController isKindOfClass:[BCBaseViewController class]]) {
		BCBaseViewController *hVc = (BCBaseViewController*)viewController;
        hVc.hk_parent = self.topViewController;
	} else if ([viewController isKindOfClass:[BCBaseNavigationController class]]) {
		BCBaseNavigationController *hNc = (BCBaseNavigationController*)viewController;
        hNc.hk_parent = self.topViewController;
	}
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    if ([viewController isKindOfClass:[BCBaseViewController class]]) {
        ((BCBaseViewController *)viewController).animating = animated;
    }
    
    
    NSLog(@"********** %@  %@", NSStringFromSelector(_cmd), viewController);
    [super pushViewController:viewController animated:animated];
}

- (UIViewController*)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [super popViewControllerAnimated:animated];
    }
    
    if (self.popingController == self.topViewController && [CommonUtils iOS8]) {
        return [super popViewControllerAnimated:animated];
    }
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        if (((BCBaseViewController *)self.topViewController).animating) {
            NSLog(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
            return nil;
        }
        [((BCBaseViewController *)self.topViewController) onPop];
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    if ([CommonUtils iOS5]) {
        if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
            if (((BCBaseViewController *)self.topViewController).viewState == viewStateAppearing) {
                NSLog(@"iOS 5 %@ controller(%@) pop when view appearing.", NSStringFromSelector(_cmd), self.topViewController);
                return nil;
            }
        }
    }
    
    NSLog(@"********** %@ %@ ",NSStringFromSelector(_cmd), self.topViewController);
    
    if (self.viewControllers.count > 2) {
        UIViewController *backController = self.viewControllers[self.viewControllers.count - 2];
        if ([backController isKindOfClass:[BCBaseViewController class]]) {
            ((BCBaseViewController *)backController).animating = animated;
        }
    }
    
    self.popingController = self.topViewController;
    UIViewController *popedViewController = [super popViewControllerAnimated:animated];
    self.popingController = nil;
    
    return popedViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [super popToViewController:viewController animated:animated];
    }
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        if (((BCBaseViewController *)self.topViewController).animating) {
            NSLog(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
            return nil;
        }
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    if ([CommonUtils iOS5]) {
        if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
            if (((BCBaseViewController *)self.topViewController).viewState == viewStateAppearing) {
                NSLog(@"iOS 5 %@ controller(%@) pop when view appearing.", NSStringFromSelector(_cmd), self.topViewController);
                return nil;
            }
        }
    }
    
    NSLog(@"********** %@ %@ ", NSStringFromSelector(_cmd), self.topViewController);
    NSArray *popedViewControllerList = [super popToViewController:viewController animated:animated];
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    return popedViewControllerList;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 1) {
        return [super popToRootViewControllerAnimated:animated];
    }
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        if (((BCBaseViewController *)self.topViewController).animating) {
            NSLog(@"%@ controller(%@) pop when animating.", NSStringFromSelector(_cmd), self.topViewController);
            return nil;
        }
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    if ([CommonUtils iOS5]) {
        if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
            if (((BCBaseViewController *)self.topViewController).viewState == viewStateAppearing) {
                NSLog(@"iOS 5 %@ controller(%@) pop when view appearing.", NSStringFromSelector(_cmd), self.topViewController);
                return nil;
            }
        }
    }
    
    NSLog(@"********** %@ %@ ", NSStringFromSelector(_cmd), self.topViewController);
    NSArray *popedViewControllerList = [super popToRootViewControllerAnimated:animated];
    
    if ([self.topViewController isKindOfClass:[BCBaseViewController class]]) {
        ((BCBaseViewController *)self.topViewController).animating = animated;
    }
    
    return popedViewControllerList;
}

- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated
{
    [self presentViewController:modalViewController animated:animated completion:nil];
}

- (void)presentViewController:(UIViewController *)modalViewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!modalViewController) {
        NSLog(@"%@ controller(%@) is nil.", NSStringFromSelector(_cmd), modalViewController);
        return;
    }
    
    if (self.animating) {
        NSLog(@"%@ controller(%@) present when animating.", NSStringFromSelector(_cmd), modalViewController);
        return;
    }
    
	if ([modalViewController isKindOfClass:[BCBaseViewController class]]) {
		BCBaseViewController *baseViewController = (BCBaseViewController *)modalViewController;
		baseViewController.hk_parent = self;
        baseViewController.animating = animated;
	} else if ([modalViewController isKindOfClass:[BCBaseNavigationController class]]) {
		BCBaseNavigationController *hookNavigationViewController = (BCBaseNavigationController*)modalViewController;
        if ([hookNavigationViewController.topViewController isKindOfClass:[BCBaseViewController class]]) {
            BCBaseViewController *baseViewController = (BCBaseViewController *)hookNavigationViewController.topViewController;
            baseViewController.hk_parent = self;
            baseViewController.animating = animated;
        }
		hookNavigationViewController.hk_parent = self;
        hookNavigationViewController.animating = animated;
	}
    
    
    NSLog(@"hooknavigation navigationcontroller present %@", modalViewController);
    [super presentViewController:modalViewController animated:animated completion:^{
        self.animating = NO;
        if (completion) {
            completion();
        }
    }];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated
{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** dismissModalViewControllerAnimated %@ animated: %d", className, animated);
    [super dismissModalViewControllerAnimated:animated];
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** dismissViewControllerAnimated %@ animated: %d completion", className, animated);
    [super dismissViewControllerAnimated:animated completion:completion];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.animating = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.animating = NO;
}

- (void)onBaseNavigationControllerDidEnterBackground:(id)sender
{
    self.animating = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
