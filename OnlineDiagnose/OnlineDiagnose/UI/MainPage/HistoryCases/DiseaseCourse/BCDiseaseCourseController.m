//
//  BCDiseaseCourseController.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/22/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCDiseaseCourseController.h"
#import "BCDiseaseCourseModel.h"
#import "BCDiseaseCourseCell.H"

@implementation BCDiseaseCourseController

- (instancetype)init
{
    if (self = [super init]) {
        self.enableFooterRefreshView = NO;
        self.enableHeaderRefreshView = NO;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -- UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.diseaseCourses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BCDiseaseCourseModel *courseModel = [self.diseaseCourses objectAtIndex:indexPath.row];
    
    BCDiseaseCourseCell* cell = (BCDiseaseCourseCell *)[tableView dequeueReusableCellWithIdentifier:@"DISEASE_COURSE_CELL"];
    if (cell == nil)
    {
        cell = [[BCDiseaseCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DISEASE_COURSE_CELL"];
    }
    
    //隐藏上分割线，显示底部分割线
    cell.hideTopSeparatorLine = YES;
    cell.hideBottomSeparatorLine = NO;
    cell.hideSeparatorLineOnBothEnds = YES;
    cell.separatorLineInset = 30;
    [cell setAppearanceWithRow:indexPath.row inTotal:self.diseaseCourses.count];

    
    cell.courseModel = courseModel;
    
    return cell;
}

#pragma mark -- UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BCDiseaseCourseModel *courseModel = [self.diseaseCourses objectAtIndex:indexPath.row];
    return [BCDiseaseCourseCell estimatedHeightWithModel:courseModel];
}

@end
