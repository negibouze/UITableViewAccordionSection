//
//  CustomSectionHeaderView.m
//  UITableViewAccordionSection
//
//  Created by Yoshiaki Itakura on 2014/03/24.
//  Copyright (c) 2014年 Yoshiaki Itakura. All rights reserved.
//

#import "CustomSectionHeaderView.h"

@implementation CustomSectionHeaderView
{
    UIImageView *arrowImgView_;
    UIImage *downImg_;
    UIImage *rightImg_;
    CGSize downImgSize_;
    CGSize rightImgSize_;
    BOOL isOpen_;
    NSInteger index_;
}

#pragma mark - initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// デフォルト設定で初期化
- (id)initWithTitle:(NSString *)title
       sectionIndex:(NSInteger)index
             isOpen:(BOOL)isOpen
{
    self = [super init];
    if (self) {
        [self setDefaultStyle];
        [self setTitle:title];
        [self setIndex:index];
        [self setOpenState:isOpen];
        [self switchArrowImg];
        [self addTapGesture];
    }
    return self;
}

#pragma mark - Public Methods

// セクションのタイトルを設定する
- (void)setTitle:(NSString *)title
{
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.text = title;
    titleLbl.textColor = [UIColor whiteColor];
    titleLbl.backgroundColor = [UIColor clearColor];
    [titleLbl sizeToFit];
    CGSize lglSize = titleLbl.frame.size;
    titleLbl.frame = CGRectMake(50, 10, lglSize.width, lglSize.height);
    [self addSubview:titleLbl];
}

// セクションのインデックスを設定する
- (void)setIndex:(NSInteger)index
{
    index_ = index;
}

// セクションの開閉状態を設定する
- (void)setOpenState:(BOOL)isOpen
{
    isOpen_ = isOpen;
}

#pragma mark - Private Methods

/**
 デフォルトのスタイル設定
 */
- (void)setDefaultStyle
{
    downImg_ = [UIImage imageNamed:@"downArrow"];
    rightImg_ = [UIImage imageNamed:@"rightArrow"];
    downImgSize_ = downImg_.size;
    rightImgSize_ = rightImg_.size;

    arrowImgView_ = [[UIImageView alloc] init];

    self.backgroundColor = [UIColor blackColor];
    [self addSubview:arrowImgView_];
}

/**
 タップジェスチャを追加
 */
- (void)addTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(sigleTapped)];
    [self addGestureRecognizer:singleTap];
}

/**
 シングルタップイベント
 */
- (void)sigleTapped
{
    isOpen_ = isOpen_ ? NO : YES;
    [self switchArrowImg];
    [self.delegate didSectionHeaderSingleTap:index_ isOpen:isOpen_];
}

/**
 矢印画像を切り替える
 */
- (void)switchArrowImg
{
    if (isOpen_) {
        arrowImgView_.image = downImg_;
        arrowImgView_.frame = CGRectMake(20, 15, downImgSize_.width, downImgSize_.height);
    } else {
        arrowImgView_.image = rightImg_;
        arrowImgView_.frame = CGRectMake(25, 12, rightImgSize_.width, rightImgSize_.height);
    }
}

@end
