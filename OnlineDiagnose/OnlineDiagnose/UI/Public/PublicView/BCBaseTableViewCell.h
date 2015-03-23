//
//  BCBaseTableViewCell.h
//  QZone
//
//  Created by batiliu on 13-9-2.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultCellBackgroundColor                      UIColorFromRGB(0xffffff)
#define DefaultCellHighlightedBackgroundColor           UIColorFromRGB(0xdfdfdf)
#define DefaultCellSeperatorLineColor                   UIColorFromRGB(0x000000)

#define DefaultSeperaorLineHeight                       ([CommonUtils retinaDisplay] ? .5 : 1)

typedef enum LOCATION_TYPE_
{
    LOCATION_TOP,
    LOCATION_MIDDLE,
    LOCATION_BOTTOM,
    LOCATION_SINGLE
}LOCATION_TYPE;

@interface BCBaseTableViewCell : UITableViewCell

@property(nonatomic,strong) UIColor* topSeparatorLineColor;     // 上边线颜色
@property(nonatomic,strong) UIColor* bottomSeparatorLineColor;  // 下边线颜色
@property(nonatomic,assign) CGFloat seperatorLineHeight;        // 边线的高度
@property(nonatomic,assign) CGFloat separatorLineInset;         // 边线的缩进

@property(nonatomic,assign) BOOL hideSeparatorLineOnBothEnds;   // 整个列表的头尾两条线是否隐藏
@property(nonatomic,assign) BOOL hideSeparatorLineAlways;       // 始终隐藏边线
@property(nonatomic,assign) BOOL hideTopSeparatorLine;          // 始终隐藏上边线
@property(nonatomic,assign) BOOL hideBottomSeparatorLine;       // 始终隐藏下边线

@property (strong, nonatomic) UIView *topSeparatorLine;
@property (strong, nonatomic) UIView *bottomSeparatorLine;
@property (strong, nonatomic) UIView *topSeparatorLineOnBg;
@property (strong, nonatomic) UIView *bottomSeparatorLineOnBg;

@property (assign, nonatomic) LOCATION_TYPE locationType;

- (void)setPosition:(LOCATION_TYPE)position;                                // 设置Cell是在上方，下方，还是中间，会影响边线的缩进
- (void)setAppearanceWithRow:(NSInteger)row inTotal:(NSInteger)totleRowNum; // 设置Cell在TableView中的位置，内部自动调整Position



@end
