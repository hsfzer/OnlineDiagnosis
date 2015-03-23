//
//  QzoneBaseButton.m
//  QZone
//
//  Created by AllenMa on 15-3-13.
//  Copyright (c) 2015年 tencent. All rights reserved.
//

#import "BCBaseButton.h"


@interface BCBaseButton ()

@property (strong, nonatomic) UIColor *highlightedBackgroundColor;
@property (strong, nonatomic) UIColor *normalBackgroundColor;
@property (strong, nonatomic) UIColor *selectedBackgroundColor;
@property (strong, nonatomic) UIColor *disabledBackgroundColor;

@property (strong, nonatomic) UIImage *originalImage;
@property (strong, nonatomic) UIImage *originalHighlightedImage;
@property (strong, nonatomic) UIImage *originalSelectedImage;
@property (strong, nonatomic) UIImage *originalDisabledImage;

@property (strong, nonatomic) UIColor *originalTitleColor;
@property (strong, nonatomic) UIColor *originalHighlightedTitleColor;
@property (strong, nonatomic) UIColor *originalSelectedTitleColor;
@property (strong, nonatomic) UIColor *originalDisabledTitleColor;

@end

@implementation BCBaseButton


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        if (self.highlightedBackgroundColor) {
            self.backgroundColor = self.highlightedBackgroundColor;
        }
    } else {
        if (self.normalBackgroundColor) {
            self.backgroundColor = self.normalBackgroundColor;
        }
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        if (self.normalBackgroundColor) {
            self.backgroundColor = self.normalBackgroundColor;
        }
    } else {
        if (self.disabledBackgroundColor) {
            self.backgroundColor = self.disabledBackgroundColor;
        }
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        if (self.selectedBackgroundColor) {
            self.backgroundColor = self.selectedBackgroundColor;
        }
    } else {
        if (self.normalBackgroundColor) {
            self.backgroundColor = self.normalBackgroundColor;
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.normalBackgroundColor = color;
            break;
        case UIControlStateHighlighted:
            self.highlightedBackgroundColor = color;
            break;
        case UIControlStateDisabled:
            self.disabledBackgroundColor = color;
            break;
        case UIControlStateSelected:
            self.selectedBackgroundColor = color;
            break;
        default:
            break;
    }
    if (self.state & state || self.state == state) {
        self.backgroundColor = color;
    }
}



- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.originalImage = image;
            break;
        case UIControlStateHighlighted:
            self.originalHighlightedImage = image;
            break;
        case UIControlStateSelected:
            self.originalSelectedImage = image;
            break;
        case UIControlStateDisabled:
            self.originalDisabledImage = image;
            break;
        default:
            break;
    }
    [super setImage:image forState:state];
}


- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    switch (state) {
        case UIControlStateNormal:
            self.originalTitleColor = color;
            break;
        case UIControlStateHighlighted:
            self.originalHighlightedTitleColor = color;
            break;
        case UIControlStateSelected:
            self.originalSelectedTitleColor = color;
            break;
        case UIControlStateDisabled:
            self.originalDisabledTitleColor = color;
            break;
        default:
            break;
    }
    [super setTitleColor:color forState:state];
}

- (void)verticalCenterImageAndTitleWithSpacing:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    //    CGSize titleSize = self.titleLabel.frame.size;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:self.bounds.size];
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0);
}

@end
