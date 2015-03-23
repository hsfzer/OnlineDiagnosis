//
//  BCBaseTableViewController.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/19/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCBaseTableViewController.h"
#import "CommonUtils.h"
#import "UIView+MJExtension.h"
#import "MJRefresh.h"



@interface BCBaseTableViewController() <UIScrollViewDelegate>

@property (nonatomic, assign)    CGPoint       tableViewContentOffset;
@property (nonatomic, readwrite) UITableView   *tableView;

//是否正在加载数据
@property (nonatomic, assign)    BOOL           isLoading;

@end

@implementation BCBaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (isIOS7) {
            self.automaticallyAdjustsScrollViewInsets = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _enableHeaderRefreshView = YES;
        _enableFooterRefreshView = YES;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
    [self initRefreshHeaderView];
    [self initRefreshFooterView];
}

- (void)viewDidUnload
{
    //当内存警告时,保存当前TableView的Offset
    self.tableViewContentOffset = self.tableView.contentOffset;
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [super viewDidUnload];
}


#pragma mark - override
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - 初始化视图
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.contentInset = self.defaultTableViewInsets;
    self.tableView.contentOffset = self.tableViewContentOffset;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)initRefreshHeaderView
{
    if (!self.enableHeaderRefreshView) {
        return;
    }
    
    DECLARE_WEAK_SELF;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        DECLARE_STRONG_SELF;
        if (!strongSelf) {
            return;
        }
        //下拉刷新和上拉刷新必须互斥
        if (strongSelf.isLoading) {
            [strongSelf.tableView.header endRefreshing];
            return;
        }
        strongSelf.isLoading = YES;
        [strongSelf didTriggerPullToRefresh];
    }];
}

- (void)initRefreshFooterView
{
    if (!self.enableFooterRefreshView) {
        return;
    }
    
    DECLARE_WEAK_SELF;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        DECLARE_STRONG_SELF;
        if (!strongSelf) {
            return;
        }
        //下拉刷新和上拉刷新必须互斥
        if (strongSelf.isLoading)
        {
            [strongSelf.tableView.footer setState:MJRefreshFooterStateIdle];
            return;
        }
        strongSelf.isLoading = YES;
        [strongSelf didTriggerLoadMoreData];
    }];

}

- (void)reloadTable
{
    [self.tableView reloadData];
}


#pragma mark -- Pull to Refresh

- (void)didTriggerPullToRefresh
{
}

- (void)hideHeaderRefreshView
{
    if (self.enableHeaderRefreshView)
    {
        self.isLoading = NO;
        [self.tableView.header endRefreshing];
    }
}

- (void)setEnableHeaderRefreshView:(BOOL)enable
{
    if (enable != _enableHeaderRefreshView)
    {
        self.tableView.header.hidden = !enable;
        _enableHeaderRefreshView = enable;
    }
}



#pragma mark -- Pull to Refresh
- (void)didTriggerLoadMoreData
{
}

- (void)setFooterRefreshViewState:(CBRefreshFootViewState)state
{
    if (self.enableFooterRefreshView)
    {
        switch (state) {
            case CBRefreshFootViewStateFinishLoading:
                self.isLoading = NO;
                [self.tableView.footer setState:MJRefreshFooterStateIdle];
                break;
            case CBRefreshFootViewStateNoMoreData:
                self.isLoading = NO;
                [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
                break;
            default:
                [self.tableView.footer setState:MJRefreshFooterStateIdle];
                break;
        }
    }
}

- (void)setEnableFooterRefreshView:(BOOL)enable
{
    if (enable != _enableFooterRefreshView)
    {
        self.tableView.footer.hidden = !enable;
        _enableFooterRefreshView = enable;
    }
}


@end
