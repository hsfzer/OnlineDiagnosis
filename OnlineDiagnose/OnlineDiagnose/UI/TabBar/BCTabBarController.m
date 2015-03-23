//
//  QZoneTabBarController.m
//  QZone
//
//  Created by tedliu on 12-10-9.
//  Copyright (c) 2012年 tencent. All rights reserved.
//

#import "BCTabBarController.h"

@interface BCTabBarController ()
@property (nonatomic, strong)   NSMutableArray  *items;
@property (nonatomic, assign)   NSInteger        curIndex;
@end

@implementation BCTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //设置tabbar背景
	UIImage *tabBarBgImage = [UIImage imageNamed:(@"tabbar_bg.png")];
    if(_bgImageView == nil)
    {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.frame = CGRectMake(0, (QZoneTabBarHeight - tabBarBgImage.size.height), kScreenWidth, tabBarBgImage.size.height);
        _bgImageView.userInteractionEnabled = YES;
        [self.tabBar insertSubview:_bgImageView atIndex:0];
    }

    [self.tabBar sendSubviewToBack:_bgImageView];
    _bgImageView.image = tabBarBgImage;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    _bgImageView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark tabbar
- (void)autoFixSize:(CGFloat *)itemXs itemWidth:(CGFloat *)itemWidth
{
    CGFloat btnWidth = (kScreenWidth - QZ_ADAPT_WIDTH(76)) / 4;
    
    for (int i = 0; i < 5; ++i) {
        if (i != 2) {
            itemWidth[i] = btnWidth;
        } else {
            itemWidth[i] = QZ_ADAPT_WIDTH(76);
        }
    }
    
    CGFloat posX = 0;
    for (int i = 0; i < 5; ++i) {
        itemXs[i] = posX;
        posX += itemWidth[i];
    }
}


- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
	[super setViewControllers:viewControllers animated:animated];
	
    if (self.view) {
        //Do Nothing, just need call viewDidLoad
    }
	float _heightToolBar = QZoneTabBarHeight;
	
    
    CGFloat itemXs[5] = {0, 61, 122, 198, 259};
    CGFloat itemWidth[5] = {61, 61, 76, 61, 61};
    [self autoFixSize:itemXs itemWidth:itemWidth];
    
    NSArray *titleArray = @[@"主页", @"健康护理", @"+", @"指南", @"设置"];
    NSArray *iconImageArray = @[@"tabbar_icon_auth.png", @"tabbar_icon_at.png",@"tabbar_btn.png", @"tabbar_icon_space.png", @"tabbar_icon_more.png"];
    NSArray *iconSelectedImageArray = @[@"tabbar_icon_auth_click.png", @"tabbar_icon_at_click.png",@"tabbar_btn_click.png",@"tabbar_icon_space_click.png" , @"tabbar_icon_more_click.png"];
    _items = [[NSMutableArray alloc] initWithCapacity:[viewControllers count]];
    
    for (id view in self.tabBar.subviews) {
        if ([view isKindOfClass:[BCTabBarItem class]]) {
            [view removeFromSuperview];
        }
    }
	for (int i = 0; i < [viewControllers count]; i++) {		
        //创建tabBarItem
        CGRect _rectFrame = {itemXs[i], 0, itemWidth[i], _heightToolBar} ;
        UIControl *tabBarItem = nil;
        UIImage *normalIcon = [UIImage imageNamed:[iconImageArray objectAtIndex:i]];
        UIImage *highLightIcon =[UIImage imageNamed:[iconSelectedImageArray objectAtIndex:i]];
        
        if (i == 2) {
            _centerItem = [[BCTabBarCenterItem alloc] initWithFrame:_rectFrame];
            [_centerItem setNormalImage:normalIcon selectedImage:highLightIcon];
            tabBarItem = _centerItem;
             [self.tabBar addSubview:_centerItem];
        } else {
            
            BCTabBarItem *item = [[BCTabBarItem alloc] initWithFrame:_rectFrame];
            
            NSString *title = [titleArray objectAtIndex:i];
            [item setTitle:title];
            [item setNormalImage:normalIcon selectedImage:highLightIcon];

            [self.tabBar addSubview:item];
            
            tabBarItem = item;
        }

        tabBarItem.tag = i;
        [tabBarItem addTarget:self action:@selector(onClickTabBarItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [_items addObject:tabBarItem];
	}
    
}


#pragma mark -- override me
- (void)onClickTabBarItem:(id)sender
{
    UIControl *tabBarItem = (UIControl *)sender;
    [self setSelectedIndex:tabBarItem.tag];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex >= [_items count] || selectedIndex == _curIndex) {
        return;
    }
    
    if (selectedIndex == 2) {
        NSLog(@"加号动画开启");
        _centerItem.selected = YES;
        [self presentProfileController];
    }
    else{
        [super setSelectedIndex:selectedIndex];
        [self changeSwitchTabIndexActive:selectedIndex];
    }
}


- (void)presentProfileController
{
    NSLog(@"___presentProfileController");
}


- (void)changeSwitchTabIndexActive:(NSUInteger)index
{
    for (UIControl *item in _items) {
        item.selected = NO;
    }
    
    _curIndex = index;
    UIControl *item = [_items objectAtIndex:_curIndex];
    item.selected = YES;
}



#pragma mark -
#pragma mark ui相关




@end
