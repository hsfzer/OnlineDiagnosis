//
//  BCTabBarItem.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/7/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation BCFakeTabBarItem
//Override setTitle to fo nothing
- (void)setTitle:(NSString *)title
{}
@end

@implementation BCTabBarItem

#define ROTATION_ANGLE  (-M_PI_4-M_PI_2)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        float titleLabelHeight = 10.0f;
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -16, frame.size.width, 65)];

        self.iconImageView.backgroundColor = [UIColor clearColor];
        self.iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - titleLabelHeight - 4, frame.size.width, titleLabelHeight)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:10];
        [self addSubview:self.titleLabel];
    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    self.normalImage = normalImage;
    self.selectedImage = selectedImage;
    
    if (self.selected) {
        self.iconImageView.image = _selectedImage;
    } else {
        self.iconImageView.image = _normalImage;
    }
}

- (void)setTitleColor:(UIColor *)color selectedColor:(UIColor *)selectedTitleColor
{
    _titleLabel.textColor = color;
    _titleLabel.highlightedTextColor = selectedTitleColor;
}

- (void)setSelected:(BOOL)selected
{
    if (self.selected == selected) {
        return;
    }
    
    [super setSelected:selected];
    if (selected) {
        _iconImageView.image = _selectedImage;
    } else {
        _iconImageView.image = _normalImage;
        
    }
    _titleLabel.highlighted = selected;
}

@end

@implementation BCTabBarCenterItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.iconImageView.backgroundColor = [UIColor clearColor];
        self.iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.iconImageView];
        
        _shouldTransform = YES;
    }
    return self;
}

- (void)performActiveAnimation
{
    _iconImageView.image = _selectedImage;
    if (!self.shouldTransform)
        return;
    CGFloat angle = ROTATION_ANGLE;
    _iconImageView.transform = CGAffineTransformMakeRotation(angle);
    
    [UIView beginAnimations:@"rotateup" context:nil];
    [UIView setAnimationDuration:0.3f];
    _iconImageView.transform = CGAffineTransformMakeRotation(0.0f);
    [UIView commitAnimations];
}

- (void)performInactiveAnimation
{
    _iconImageView.image = _normalImage;
    if (!self.shouldTransform)
        return;
    CGFloat angle = ROTATION_ANGLE;
    _iconImageView.transform = CGAffineTransformMakeRotation(-angle);
    
    [UIView beginAnimations:@"rotatedown" context:nil];
    [UIView setAnimationDuration:0.3f];
    _iconImageView.transform = CGAffineTransformMakeRotation(0.0f);
    [UIView commitAnimations];
}


- (void)setSelected:(BOOL)selected
{
    if (self.selected == selected) {
        return;
    }   
    if (selected) {
        [self performActiveAnimation];
    } else {
        [self performInactiveAnimation];
    }
    [super setSelected:selected];
}

- (void)setNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage
{
    self.normalImage = normalImage;
    self.selectedImage = selectedImage;
    
    if (self.selected) {
        self.iconImageView.image = _selectedImage;
    } else {
        self.iconImageView.image = _normalImage;
    }
}

@end
