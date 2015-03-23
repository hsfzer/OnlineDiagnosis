//
//  BCBaseButton.h
//
//  Created by AllenMa on 15-03-13.
//  Copyright (c) 2015年 tencent. All rights reserved.
//

@interface BCBaseButton : UIButton

/**
 *  @breif 设置各个状态下的背景色
 */
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  垂直居中按钮 image 和 title
 *
 *  @param spacing - image 和 title 的垂直间距, 单位point
 */
- (void)verticalCenterImageAndTitleWithSpacing:(float)spacing;

@end
