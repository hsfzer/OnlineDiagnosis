//
//  BCPullToRefreshFooterView.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/20/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCPullToRefreshFooterView.h"

@interface BCPullToRefreshFooterView ()

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, strong)    UILabel       *refreshLabel;
@property (nonatomic, strong)    UIImageView   *refreshArrow;

@property (nonatomic, strong)    UIActivityIndicatorView  *refreshSpinner;

@end

@implementation BCPullToRefreshFooterView

- (instancetype)init
{
    NSAssert(0, @"Call initWithFrame");
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupDefaultRefreshText];
        
        self.refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, REFRESH_FOOTER_HEIGHT)];
        self.refreshLabel.backgroundColor = [UIColor clearColor];
        self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        
        self.refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
        self.refreshArrow.frame = CGRectMake(floorf((REFRESH_FOOTER_HEIGHT - 27) / 2),
                                             (floorf(REFRESH_FOOTER_HEIGHT - 44) / 2),
                                             27, 44);
        
        self.refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_FOOTER_HEIGHT - 20) / 2), floorf((REFRESH_FOOTER_HEIGHT - 20) / 2), 20, 20);
        self.refreshSpinner.hidesWhenStopped = YES;
        
        [self addSubview:self.refreshLabel];
        [self addSubview:self.refreshArrow];
        [self addSubview:self.refreshSpinner];
    }
    
    return self;
}


- (void)setupDefaultRefreshText
{
    self.pullText    = @"下拉刷新";
    self.releaseText = @"释放刷新";
    self.loadingText = @"正在刷新...";
}


- (void)refreshScrollViewBeginScroll:(UIScrollView *)scrollView
{
    if (self.isLoading) return;
    
    self.isDragging = YES;
}

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isDragging && (scrollView.contentOffset.y+scrollView.frame.size.height) >= scrollView.contentSize.height)
    {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if ((scrollView.contentOffset.y+scrollView.frame.size.height) > scrollView.contentSize.height+REFRESH_FOOTER_HEIGHT)
            {
                // User is scrolling above the header
                self.refreshLabel.text = self.releaseText;
                [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
            else
            {
                // User is scrolling somewhere within the header
                self.refreshLabel.text = self.pullText;
                [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            }
        }];
    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (self.isLoading)
        return;
    self.isDragging = NO;
    
   if ((scrollView.contentOffset.y+scrollView.frame.size.height) > scrollView.contentSize.height+REFRESH_FOOTER_HEIGHT)
    {
        // Released above the header
        [self triggerPullToRefresh:scrollView];
    }
}

- (void)triggerPullToRefresh:(UIScrollView *)scrollView
{
    self.isLoading = YES;
    UIEdgeInsets defaultInset = scrollView.contentInset;
    // Show the header
    
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(defaultInset.top + REFRESH_FOOTER_HEIGHT, defaultInset.left, defaultInset.bottom, defaultInset.right);
        self.refreshLabel.text = self.loadingText;
        self.refreshArrow.hidden = YES;
        [self.refreshSpinner startAnimating];
    }];
    
    // Refresh action!
//    [self.delegate pullToRefreshViewRefreshing:self];
    
}

- (void)refreshScrollViewDidFinishedLoading:(UIScrollView *)scrollView
{
    self.isLoading = NO;
    UIEdgeInsets defaultInset = scrollView.contentInset;
    // Hide the header
    [UIView animateWithDuration:0.3
                     animations:^{
                         scrollView.contentInset = UIEdgeInsetsMake(defaultInset.top - REFRESH_FOOTER_HEIGHT, defaultInset.left, defaultInset.bottom, defaultInset.right);;
                         [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
                     }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}


- (void)stopLoadingComplete
{
    // Reset the header
    self.refreshLabel.text = self.pullText;
    self.refreshArrow.hidden = NO;
    [self.refreshSpinner stopAnimating];
}
@end
