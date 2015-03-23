//
//  BCDiseaseCourseModel.h
//  OnlineDiagnose
//
//  Created by AllenMa on 3/22/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BCDiseaseCourseEvent)
{
    BCDiseaseCourseEventFirstDiag,      //首诊
    BCDiseaseCourseEventSubVisit,       //复诊
    BCDiseaseCourseEventAdmission,      //入院
    BCDiseaseCourseEventDischarge,      //出院
    BCDiseaseCourseEventSugery,         //手术
    BCDiseaseCourseEventScreenage,      //影像
    BCDiseaseCourseEventTherapy,        //化疗

};

typedef NS_ENUM(NSInteger, BCMediaType)
{
    BCMediaTypePhoto,
    BCMediaTypeAudio,
    BCMediaTypeVideo,
};

@interface BCMediaElement : NSObject
@property (nonatomic, assign)   BCMediaType  mediaType;
//资源的路径
@property (nonatomic, strong)   NSString     *mediaPath;
@end



@interface BCDiseaseCourseModel : NSObject

@property (nonatomic, strong)  NSMutableArray           *mediaRecords;

@property (nonatomic, assign)  NSInteger                createDate;

@property (nonatomic, strong)  NSString                 *remarks;

@property (nonatomic, assign) BCDiseaseCourseEvent      courceEvent;

@end
