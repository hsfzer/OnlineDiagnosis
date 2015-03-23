//
//  BCDiseaseCourseController.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/22/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCBaseTableViewController.h"

@interface BCDiseaseCourseController : BCBaseTableViewController
@property (nonatomic, strong) id                patientProfile;
@property (nonatomic, strong) NSMutableArray    *diseaseCourses;
@end
