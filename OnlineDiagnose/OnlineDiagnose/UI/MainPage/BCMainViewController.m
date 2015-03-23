//
//  BCMainViewController.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/15/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCMainViewController.h"
#import "BCBaseButton.h"
#import "BCDiseaseCourseController.h"
#import "BCDiseaseCourseModel.h"

typedef NS_ENUM(NSInteger, MainPageEntry)
{
    MainPageEntryRegister,         // 挂号预约
    MainPageEntryTumor,            // 肿瘤门诊
    MainPageEntryBroadCast,        // 健康播报
    MainPageEntryNearby,           // 周边信息
    MainPageEntryHistory,          // 病例列表
    MainPageEntryCommunity,        // 病友社区
};

#define  kBCMainPageIconWidth               (85)
#define  kBCMainPageIconHeight              (84 + 30)
#define  kBCMainPageIconHorizonalMargin     (kScreenWidth - kBCMainPageIconWidth*kBCMainPageIconRowNum)/(kBCMainPageIconRowNum + 1)
#define  kBCMainPageIconVerticalMargin      20

#define  kBCMainPageIconRowNum              2

@interface BCMainViewController ()

@end

@implementation BCMainViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.title = @"首页";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupMainPage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupMainPage
{
    NSArray *titleArray = @[@"挂号预约", @"肿瘤门诊", @"健康播报", @"周边信息", @"病例列表",@"病友社区"];
    NSArray *iconImageArray = @[@"mp_icon_register.png", @"mp_icon_tumor.png",@"mp_icon_broadcast.png", @"mp_icon_nearby.png", @"mp_icon_history.png",@"mp_icon_community.png"];
    
    CGFloat startX, startY;
    NSInteger colunmIndex = 0, rowIndex = 0;
    NSString *titleName = nil, *iconImageName = nil;
    CGRect iconFrame;
    BCBaseButton *iconView = nil;
    
    for (int i = 0; i < titleArray.count; i++)
    {
        titleName     = [titleArray objectAtIndex:i];
        iconImageName = [iconImageArray objectAtIndex:i];
        
        colunmIndex = i % kBCMainPageIconRowNum;
        rowIndex = i / kBCMainPageIconRowNum;
        startX = (colunmIndex + 1) * kBCMainPageIconHorizonalMargin + kBCMainPageIconWidth * colunmIndex;
        startY = (rowIndex + 1) * kBCMainPageIconVerticalMargin + kBCMainPageIconHeight * rowIndex;
        
        iconFrame = CGRectMake(startX, startY, kBCMainPageIconWidth, kBCMainPageIconHeight);
        
        iconView = [[BCBaseButton alloc] initWithFrame:iconFrame];
        
        [iconView setImage:[UIImage imageNamed:iconImageName] forState:UIControlStateNormal];
        iconView.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [iconView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [iconView setTitle:titleName forState:UIControlStateNormal];

        iconView.tag =  i;

        [iconView addTarget:self action:@selector(onClickIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:iconView];
       
        [iconView verticalCenterImageAndTitleWithSpacing:12.f];
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)onClickIcon:(id)sender
{
    UIButton *entryBtn = (UIButton *)sender;
    NSLog(@"Icon click index:%zd",entryBtn.tag);
    if (entryBtn.tag == MainPageEntryHistory)
    {
        BCDiseaseCourseController *diseaseCourseCon = [[BCDiseaseCourseController alloc] init];
        diseaseCourseCon.diseaseCourses = [self fakeDiseaseCourses];
        [self.navigationController pushViewController:diseaseCourseCon animated:YES];
    }
    
}


- (NSMutableArray *)fakeDiseaseCourses
{
    NSMutableArray *models = [NSMutableArray new];
    for(int i = 0; i < 5; i++)
    {
        [models addObject:[self fakeDiseaseModel]];
    }
    
    return models;
}

- (BCDiseaseCourseModel *)fakeDiseaseModel
{
    BCDiseaseCourseModel *fakeModel = [[BCDiseaseCourseModel alloc] init];
    fakeModel.remarks = @"这些都是加数据,用来测试的,这些都是加数据,用来测试的,这些都是加数据,用来测试的";
    
    BCMediaElement *media1 = [[BCMediaElement alloc] init];
    media1.mediaPath = @"dc_audia_thumb.png";
    
    
    BCMediaElement *media2 = [[BCMediaElement alloc] init];
    media2.mediaPath = @"dc_video_thumb.png";
    
    fakeModel.mediaRecords = [NSMutableArray arrayWithObjects:media1,media2, nil];
    
    fakeModel.createDate = [[NSDate date] timeIntervalSince1970];
    
    return fakeModel;
}
@end
