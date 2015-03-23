//
//  BCBaseTableViewCell.m
//  QZone
//
//  Created by AllenMa on 15-3-20.
//  Copyright (c) 2015年 tencent. All rights reserved.
//

#import "BCBaseTableViewCell.h"



@interface BCBaseTableViewCell ()

@property (strong, nonatomic) UIImageView *backgourndImageView;

@end

@implementation BCBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _seperatorLineHeight = DefaultSeperaorLineHeight;
        _separatorLineInset = 0;
        
        self.backgroundColor = DefaultCellBackgroundColor;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = DefaultCellBackgroundColor;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _topSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _seperatorLineHeight)];
        _topSeparatorLine.backgroundColor = DefaultCellSeperatorLineColor;
        _topSeparatorLine.hidden = YES;
        _bottomSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight)];
        _bottomSeparatorLine.backgroundColor = DefaultCellSeperatorLineColor;
        _bottomSeparatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _bottomSeparatorLine.hidden = YES;
        
        [self addSubview:_topSeparatorLine];
        [self addSubview:_bottomSeparatorLine];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.selectedBackgroundView.backgroundColor = DefaultCellHighlightedBackgroundColor;
        
        
        _topSeparatorLineOnBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width, _seperatorLineHeight)];
        _topSeparatorLineOnBg.backgroundColor = DefaultCellBackgroundColor;
        _topSeparatorLineOnBg.hidden = YES;
        _bottomSeparatorLineOnBg = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _seperatorLineHeight - 0.5, self.frame.size.width, _seperatorLineHeight)];
        _bottomSeparatorLineOnBg.backgroundColor = DefaultCellBackgroundColor;
        _bottomSeparatorLineOnBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _bottomSeparatorLineOnBg.hidden = YES;
        [self.selectedBackgroundView addSubview:_topSeparatorLineOnBg];
        [self.selectedBackgroundView addSubview:_bottomSeparatorLineOnBg];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        _seperatorLineHeight = DefaultSeperaorLineHeight;
        _separatorLineInset = 0;
        
        self.backgroundColor = DefaultCellBackgroundColor;
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = DefaultCellBackgroundColor;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _topSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _seperatorLineHeight)];
        _topSeparatorLine.backgroundColor = DefaultCellSeperatorLineColor;
        _topSeparatorLine.hidden = YES;
        _bottomSeparatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight)];
        _bottomSeparatorLine.backgroundColor = DefaultCellSeperatorLineColor;
        _bottomSeparatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _bottomSeparatorLine.hidden = YES;
        
        [self addSubview:_topSeparatorLine];
        [self addSubview:_bottomSeparatorLine];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.selectedBackgroundView.backgroundColor = DefaultCellHighlightedBackgroundColor;
        
        
        _topSeparatorLineOnBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, self.frame.size.width, _seperatorLineHeight)];
        _topSeparatorLineOnBg.backgroundColor = DefaultCellBackgroundColor;
        _topSeparatorLineOnBg.hidden = YES;
        _bottomSeparatorLineOnBg = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _seperatorLineHeight - 0.5, self.frame.size.width, _seperatorLineHeight)];
        _bottomSeparatorLineOnBg.backgroundColor = DefaultCellBackgroundColor;
        _bottomSeparatorLineOnBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _bottomSeparatorLineOnBg.hidden = YES;
        [self.selectedBackgroundView addSubview:_topSeparatorLineOnBg];
        [self.selectedBackgroundView addSubview:_bottomSeparatorLineOnBg];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHideSeparatorLineAlways:(BOOL)hideSeparatorLineAlways
{
    _hideSeparatorLineAlways = hideSeparatorLineAlways;
    _topSeparatorLine.hidden = YES;
    _bottomSeparatorLine.hidden = YES;
    _topSeparatorLineOnBg.hidden = YES;
    _bottomSeparatorLineOnBg.hidden = YES;
}

- (void)setHideTopSeparatorLine:(BOOL)hideTopSeparatorLine
{
    _hideTopSeparatorLine = hideTopSeparatorLine;
    _topSeparatorLine.hidden = YES;
    _topSeparatorLineOnBg.hidden = YES;
}

- (void)setHideBottomSeparatorLine:(BOOL)hideBottomSeparatorLine
{
    _hideBottomSeparatorLine = hideBottomSeparatorLine;
    _bottomSeparatorLine.hidden = YES;
    _bottomSeparatorLineOnBg.hidden = YES;
}

- (void)setTopSeparatorLineColor:(UIColor *)topSeparatorLineColor
{
    _topSeparatorLineColor = topSeparatorLineColor;
    _topSeparatorLine.backgroundColor = topSeparatorLineColor;
    _topSeparatorLineOnBg.backgroundColor = topSeparatorLineColor;
    _bottomSeparatorLineOnBg.backgroundColor = topSeparatorLineColor;
}

- (void)setBottomSeparatorLineColor:(UIColor *)bottomSeparatorLineColor
{
    _bottomSeparatorLineColor = bottomSeparatorLineColor;
    _bottomSeparatorLine.backgroundColor = bottomSeparatorLineColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (_locationType) {
        case LOCATION_TOP:
            _topSeparatorLine.frame = CGRectMake(0, 0, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLine.frame = CGRectMake(_separatorLineInset, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            _topSeparatorLineOnBg.frame = CGRectMake(0, 0.5, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLineOnBg.frame = CGRectMake(_separatorLineInset, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            break;
        case LOCATION_BOTTOM:
            _topSeparatorLine.frame = CGRectMake(_separatorLineInset, 0, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLine.frame = CGRectMake(0, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            _topSeparatorLineOnBg.frame = CGRectMake(_separatorLineInset, 0.5, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLineOnBg.frame = CGRectMake(0, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            break;
        case LOCATION_MIDDLE:
            _topSeparatorLine.frame = CGRectMake(_separatorLineInset, 0, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLine.frame = CGRectMake(_separatorLineInset, self.frame.size.height - 1, self.frame.size.width, 1);
            _topSeparatorLineOnBg.frame = CGRectMake(_separatorLineInset, 0.5, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLineOnBg.frame = CGRectMake(_separatorLineInset, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            break;
        case LOCATION_SINGLE:
            _topSeparatorLine.frame = CGRectMake(0, 0, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLine.frame = CGRectMake(0, self.frame.size.height - _seperatorLineHeight, self.frame.size.width, _seperatorLineHeight);
            _topSeparatorLineOnBg.frame = CGRectMake(0, 0.5, self.frame.size.width, _seperatorLineHeight);
            _bottomSeparatorLineOnBg.frame = CGRectMake(0, self.frame.size.height - _seperatorLineHeight - 0.5, self.frame.size.width, _seperatorLineHeight);
            break;
        default:
            break;
    }
    
    [self bringSubviewToFront:_topSeparatorLine];
    [self bringSubviewToFront:_bottomSeparatorLine];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (LOCATION_TYPE)positionOfAppearanceWithRow:(NSInteger)row inTotal:(NSInteger)totleRowNum
{
    if (totleRowNum == 1) { //只有一行
        return LOCATION_SINGLE;
    } else if (row == 0) { //当前为第一行
        return LOCATION_TOP;
    } else if (row == totleRowNum - 1) { //最后一行
        return LOCATION_BOTTOM;
    }
    //中间行
    return LOCATION_MIDDLE;
}

- (void)setAppearanceWithRow:(NSInteger)row inTotal:(NSInteger)totleRowNum
{
    if (totleRowNum == 0) {
        return;
    }
    
    if (row >= totleRowNum) {
        return;
    }
    [self setPosition:[self positionOfAppearanceWithRow:row inTotal:totleRowNum]];
}

- (void)setPosition:(LOCATION_TYPE)position
{
    _locationType = position;
    if(self.hideSeparatorLineAlways)
    {
        return;
    }
    switch (position) {
        case LOCATION_TOP:
            if (!self.hideTopSeparatorLine) {
                self.topSeparatorLine.hidden = NO;
                self.topSeparatorLineOnBg.hidden = NO;
            }
            if (!self.hideBottomSeparatorLine) {
                self.bottomSeparatorLine.hidden = NO;
                self.bottomSeparatorLineOnBg.hidden = NO;
            }
            break;
        case LOCATION_BOTTOM:
            if (!self.hideTopSeparatorLine) {
                self.topSeparatorLineOnBg.hidden = NO;
                self.topSeparatorLine.hidden = NO;
            }
            if (!self.hideSeparatorLineOnBothEnds && !self.hideBottomSeparatorLine) {
                self.bottomSeparatorLine.hidden = NO;
                self.bottomSeparatorLineOnBg.hidden = NO;
            }
            break;
        case LOCATION_MIDDLE:
                self.topSeparatorLineOnBg.hidden = YES;
            if (!self.hideTopSeparatorLine) {
                self.topSeparatorLine.hidden = NO;
            }
            if (!self.hideBottomSeparatorLine) {
                self.bottomSeparatorLineOnBg.hidden = NO;
                self.bottomSeparatorLine.hidden = NO;
            }
            break;
        case LOCATION_SINGLE:
            if (!self.hideSeparatorLineOnBothEnds && !self.hideTopSeparatorLine && !self.hideBottomSeparatorLine) {
                self.topSeparatorLine.hidden = NO;
                self.bottomSeparatorLine.hidden = NO;
                self.topSeparatorLineOnBg.hidden = YES;
                self.bottomSeparatorLineOnBg.hidden = NO;
            }

            break;
        default:
            break;
    }
    [self setNeedsLayout];
    return;
}

@end
