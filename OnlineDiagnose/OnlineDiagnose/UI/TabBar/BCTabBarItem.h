//
//  AppDelegate.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/7/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCFakeTabBarItem : UITabBarItem
@end


@interface BCTabBarItem : UIControl

@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLabel;

- (void)setTitle:(NSString *)title;
- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;
- (void)setTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedTitleColor;

@end

//TabBar中间的大按钮
@interface BCTabBarCenterItem : UIControl

@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIImageView *iconImageView;

- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;
@property (assign, nonatomic) BOOL shouldTransform;

@end
