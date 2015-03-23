//
//  BCDiseaseCourseCell.m
//  OnlineDiagnose
//
//  Created by AllenMa on 3/22/15.
//  Copyright (c) 2015 AllenMa. All rights reserved.
//

#import "BCDiseaseCourseCell.h"

//Cell内容的内边界
#define DISEASE_CELL_CONTENT_PADDING_LEFT           30
#define DISEASE_CELL_CONTENT_PADDING_TOP            15
#define DISEASE_CELL_CONTENT_PADDING_BOTTOM         14
#define DISEASE_CELL_CONTENT_PADDING_RIGHT          10

//图片的间距
#define DISEASE_CELL_PHOTO_MARGIN                   10

//图片和备注文字的宽度
#define DISEASE_CELL_PHOTO_WIDTH                    (kScreenWidth - DISEASE_CELL_CONTENT_PADDING_LEFT - DISEASE_CELL_CONTENT_PADDING_RIGHT - DISEASE_CELL_PHOTO_MARGIN*2)/3
#define DISEASE_CELL_CONTENT_TEXT_WIDTH             (kScreenWidth - DISEASE_CELL_CONTENT_PADDING_LEFT - DISEASE_CELL_CONTENT_PADDING_RIGHT)

//字体大小
#define DISEASE_CELL_DATE_TEXT_SIZE                 15
#define DISEASE_CELL_REMARK_TEXT_SIZE               15


@interface BCDiseaseCourseCell()
@property (nonatomic, strong)  UILabel          *createDateLabel;
@property (nonatomic, strong)  UILabel          *courseEventLabel;
@property (nonatomic, strong)  UILabel          *remarkLabel;
@property (nonatomic, strong)  UIImageView      *lineView;
@property (nonatomic, strong)  UIImageView      *cycleView;

@property (nonatomic, strong)  NSMutableArray   *photoViews;
@end

@implementation BCDiseaseCourseCell

+ (CGFloat)estimatedHeightWithModel:(BCDiseaseCourseModel *)model
{
    CGSize estimatedSize = [model.remarks sizeWithFont:[UIFont systemFontOfSize:DISEASE_CELL_REMARK_TEXT_SIZE]
                                     constrainedToSize:CGSizeMake(DISEASE_CELL_CONTENT_TEXT_WIDTH, MAXFLOAT)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    
    //17是日期Label和备注Label之间的间隔 + 备注Label和图片之间的间隔
    CGFloat estimatedHeight = estimatedSize.height + DISEASE_CELL_CONTENT_PADDING_TOP + DISEASE_CELL_DATE_TEXT_SIZE +
                               DISEASE_CELL_PHOTO_WIDTH + DISEASE_CELL_CONTENT_PADDING_BOTTOM + 17 + DefaultSeperaorLineHeight + 10;
    return estimatedHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.createDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISEASE_CELL_CONTENT_PADDING_LEFT, DISEASE_CELL_CONTENT_PADDING_TOP, 90, DISEASE_CELL_DATE_TEXT_SIZE)];
        self.createDateLabel.font = [UIFont systemFontOfSize:DISEASE_CELL_DATE_TEXT_SIZE];
        self.createDateLabel.textColor = UIColorFromRGB(0x25b6ed);
        [self.contentView addSubview:self.createDateLabel];
        
        self.courseEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.createDateLabel.right + 12, self.createDateLabel.top, 100, DISEASE_CELL_DATE_TEXT_SIZE)];
        self.courseEventLabel.font = [UIFont systemFontOfSize:DISEASE_CELL_DATE_TEXT_SIZE];
        self.courseEventLabel.textColor = UIColorFromRGB(0x25b6ed);
        [self.contentView addSubview:self.courseEventLabel];
       
        self.remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISEASE_CELL_CONTENT_PADDING_LEFT, self.createDateLabel.bottom + 12, DISEASE_CELL_CONTENT_TEXT_WIDTH, DISEASE_CELL_DATE_TEXT_SIZE)];
        self.remarkLabel.numberOfLines = 0;
        self.remarkLabel.textAlignment = NSTextAlignmentLeft;
        self.remarkLabel.font = [UIFont systemFontOfSize:DISEASE_CELL_REMARK_TEXT_SIZE];
        self.remarkLabel.textColor = UIColorFromRGB(0x666666);
        [self.contentView addSubview:self.remarkLabel];
        
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 4, self.frame.size.height)];
        self.lineView.contentMode = UIViewContentModeScaleToFill;
        self.lineView.image = [UIImage imageNamed:@"dc_timeline_line.png"];
        [self.contentView addSubview:self.lineView];
        
        self.cycleView = [[UIImageView alloc] initWithFrame:CGRectMake(10, DISEASE_CELL_CONTENT_PADDING_TOP, 10, 10)];
        self.cycleView.contentMode = UIViewContentModeScaleToFill;
        self.cycleView.image = [UIImage imageNamed:@"dc_timeline_cycle.png"];
        [self.contentView addSubview:self.cycleView];
        
        self.photoViews = [NSMutableArray new];
        CGFloat startX;
        UIImageView *photoView;
        for (int i = 0; i < 3; i++) {
            //左padding + (图片宽度+图片间隔)* i
            startX = DISEASE_CELL_CONTENT_PADDING_LEFT + i * (DISEASE_CELL_PHOTO_WIDTH + DISEASE_CELL_PHOTO_MARGIN);
            photoView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, self.remarkLabel.bottom + 5, DISEASE_CELL_PHOTO_WIDTH, DISEASE_CELL_PHOTO_WIDTH)];
            photoView.hidden = YES;
            [self.contentView addSubview:photoView];
            [self.photoViews addObject:photoView];
        }
    }
    
    return self;
}

- (void)setCourseModel:(BCDiseaseCourseModel *)courseModel
{
    _courseModel = courseModel;
    [self resetSubviews];
    [self setNeedsLayout];
    
}

- (void)resetSubviews
{
    for (UIImageView *photoView in self.photoViews)
    {
        photoView.hidden = YES;
//        photoView.image = nil;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.courseModel) {
        return;
    }
    self.createDateLabel.text = @"2015 - 3 - 15";
    self.createDateLabel.frame = CGRectMake(DISEASE_CELL_CONTENT_PADDING_LEFT, DISEASE_CELL_CONTENT_PADDING_TOP, 90, DISEASE_CELL_DATE_TEXT_SIZE);
    self.courseEventLabel.text = @"测试";
    self.courseEventLabel.frame = CGRectMake(self.createDateLabel.right + 12, self.createDateLabel.top, 100, DISEASE_CELL_DATE_TEXT_SIZE);
    
    self.lineView.frame = CGRectMake(12, 0, 4, self.frame.size.height);
    self.cycleView.frame = CGRectMake(9, DISEASE_CELL_CONTENT_PADDING_TOP, 10, 10);
    
    CGSize estimatedSize = [self.courseModel.remarks sizeWithFont:self.remarkLabel.font
                                              constrainedToSize:CGSizeMake(DISEASE_CELL_CONTENT_TEXT_WIDTH, MAXFLOAT)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    CGRect labelFrame = self.remarkLabel.frame;
    self.remarkLabel.frame = CGRectMake(labelFrame.origin.x, labelFrame.origin.y, DISEASE_CELL_CONTENT_TEXT_WIDTH, estimatedSize.height);
    self.remarkLabel.text = self.courseModel.remarks;
    
    NSInteger photoCount = (self.courseModel.mediaRecords.count < 3)?self.courseModel.mediaRecords.count:3;
    UIImageView  *displayImageView = nil;
    BCMediaElement *mediaElement = nil;
    CGFloat startX;
    for (int i = 0; i < photoCount; i++)
    {
        startX = DISEASE_CELL_CONTENT_PADDING_LEFT + i * (DISEASE_CELL_PHOTO_WIDTH + DISEASE_CELL_PHOTO_MARGIN);
        displayImageView = [self.photoViews objectAtIndex:i];
        mediaElement = [self.courseModel.mediaRecords objectAtIndex:i];
        displayImageView.image = [UIImage imageNamed:@"dc_audia_thumb.png"];
        displayImageView.frame = CGRectMake(startX, self.remarkLabel.bottom + 5, DISEASE_CELL_PHOTO_WIDTH, DISEASE_CELL_PHOTO_WIDTH);
        displayImageView.hidden = NO;
    }
    
}


@end
