//
//  BCDiseaseCourseCell.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/22/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCDiseaseCourseModel.h"
#import "BCBaseTableViewCell.h"

@interface BCDiseaseCourseCell : BCBaseTableViewCell

@property (nonatomic, strong)   BCDiseaseCourseModel *courseModel;

+ (CGFloat)estimatedHeightWithModel:(BCDiseaseCourseModel *)model;
@end
