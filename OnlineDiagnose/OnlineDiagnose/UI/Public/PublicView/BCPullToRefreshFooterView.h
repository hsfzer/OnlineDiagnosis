//
//  BCPullToRefreshFooterView.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/20/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define     REFRESH_FOOTER_HEIGHT      52.0f

@class BCPullToRefreshFooterView;
@protocol BCPullToRefreshFooterViewDelegate <NSObject>
- (void)refreshFooterDidTriggerRefresh:(BCPullToRefreshFooterView *)view;
@end

@interface BCPullToRefreshFooterView : UIView


@property (nonatomic, weak)    id<BCPullToRefreshFooterViewDelegate>  delegate;

/** 自定义下拉时文字 */
@property (nonatomic, strong)   NSString       *pullText;
/** 自定义释放时文字 */
@property (nonatomic, strong)   NSString       *releaseText;
/** 加载时的文字 */
@property (nonatomic, strong)   NSString       *loadingText;


- (void)triggerPuToRefresh:(UIScrollView *)scrollView;
- (void)refreshScrollViewBeginScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView;

@end
