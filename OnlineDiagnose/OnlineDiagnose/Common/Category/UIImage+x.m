//
//  UIImage+UIImagex.m
//  FrogFarm
//
//  Created by czh0766 on 11-11-20.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+x.h"

@implementation UIImage (x)



+ (UIImage *)resizeableImageNamed:(NSString *)name capLeft:(CGFloat)left capTop:(CGFloat)top
{
    UIImage *resizeImage = [UIImage imageNamed:name];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 5.0) {
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, top, left);
        resizeImage = [resizeImage resizableImageWithCapInsets:edgeInsets];
    } else {
        resizeImage = [resizeImage stretchableImageWithLeftCapWidth:left topCapHeight:top];
    }
    return resizeImage;
}

@end
