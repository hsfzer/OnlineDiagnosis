//
//  CommonDefine.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/20/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#ifndef OnlineDiagnose_CommonDefine_h
#define OnlineDiagnose_CommonDefine_h

/******************** 常用的宏定义  ***********/
#define kScreenWidth   ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeigth  ([UIScreen mainScreen].bounds.size.height)
#define QZ_ADAPT_WIDTH(x) (kScreenWidth / 320.0 * (x))
#define isIOS8 ([CommonUtils iOS8])
#define isIOS7 ([CommonUtils iOS7])
#define isIOS6 ([CommonUtils iOS6])
#define isIOS5 ([CommonUtils iOS5])
#define IOS7_OFFSET_FIX ((isIOS7) ? 64 : 0)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#endif
