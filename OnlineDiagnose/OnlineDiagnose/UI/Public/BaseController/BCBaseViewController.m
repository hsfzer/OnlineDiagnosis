//
//  BCBaseViewController.m
//  QZone
//
//  Created by AllenMa on 15-1-12.
//  Copyright 2015 tencent. All rights reserved.
//

#import "BCBaseViewController.h"
#import "BCBaseNavigationController.h"

@implementation BCBaseViewController

- (id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onHookControllerDidEnterBackground:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        _viewState = viewStateNone;
        _isViewFirstLoad = YES;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewState = viewStateLoaded;
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ viewDidLoad", className);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.isViewFirstLoad = NO;
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.viewState = viewStateAppearing;
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ viewWillAppear", className);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewState = viewStateAppeared;
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ viewDidAppear", className);
    self.animating = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.viewState = viewStateDisappearing;
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ viewWillDisappear", className);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.viewState = viewStateDisappeared;
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ viewDidDisappear", className);
    self.animating = NO;
}

- (void)viewWillUnload
{
    [super viewWillUnload];
    self.isViewFirstLoad = NO;
    self.viewState = viewStateUnloading;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.viewState = viewStateNone;
}

- (void)onPop
{
    // empty implement.
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
		BCBaseViewController *hVc = (BCBaseViewController*)modalViewController;
		hVc.hk_parent = self;
        hVc.animating = animated;
	} else if ([modalViewController isKindOfClass:[BCBaseNavigationController class]]) {
		BCBaseNavigationController *hNc = (BCBaseNavigationController*)modalViewController;
        if ([[hNc topViewController] isKindOfClass:[BCBaseViewController class]]) {
            BCBaseViewController *hVc = (BCBaseViewController *)[hNc topViewController];
            hVc.hk_parent = self;
            hVc.animating = animated;
        }
		hNc.hk_parent = self;
        hNc.animating = animated;
	}
    
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** presentViewController %@ ", className);
    [super presentViewController:modalViewController animated:animated completion:^{
        self.animating = NO;
        if (completion) {
            completion();
        }
    }];
}

- (void)onHookControllerDidEnterBackground:(id)sender
{
    self.animating = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"********** %@ dealloc", className);
}

@end
