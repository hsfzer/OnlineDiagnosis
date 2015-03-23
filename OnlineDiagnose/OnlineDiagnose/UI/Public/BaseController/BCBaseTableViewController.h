//
//  BCBaseTableViewController.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/19/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCBaseViewController.h"

typedef NS_ENUM(NSInteger, CBRefreshFootViewState)
{
    CBRefreshFootViewStateInit,
    CBRefreshFootViewStateFinishLoading,
    CBRefreshFootViewStateNoMoreData,
};


@interface BCBaseTableViewController : BCBaseViewController <UITableViewDataSource,UITableViewDelegate>
/** tableview */
@property (nonatomic, readonly) UITableView    *tableView;
/** 默认的contentInset */
@property (nonatomic, assign)   UIEdgeInsets   defaultTableViewInsets;
/** 是否启动下拉刷新 */
@property (nonatomic, assign)   BOOL           enableHeaderRefreshView;
/** 是否启动上拉拉刷新 */
@property (nonatomic, assign)   BOOL           enableFooterRefreshView;


- (void)reloadTable;

/**! @brief 子类实现,下拉刷新已经触发，加载数据 **/
- (void)didTriggerPullToRefresh;

/**! @brief 隐藏刷新空间，刷新之后调用 **/
- (void)hideHeaderRefreshView;

/**! @brief 子类实现,上拉加载更多已经触发，加载数据 **/
- (void)didTriggerLoadMoreData;

//子类实现,上拉加载结束时调用
- (void)setFooterRefreshViewState:(CBRefreshFootViewState)state;
@end
