//
//  CustomSectionHeaderView.h
//  UITableViewAccordionSection
//
//  Created by Yoshiaki Itakura on 2014/03/24.
//  Copyright (c) 2014年 Yoshiaki Itakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomSectionHeaderViewDelegate

/**
 シングルタップ

 @param sectionIndex セクションのインデックス
 @param isOpen 開閉状態（YES:開, NO:閉）
 */
- (void)didSectionHeaderSingleTap:(NSInteger)sectionIndex isOpen:(BOOL)isOpen;

@end

@interface CustomSectionHeaderView : UIView

@property (nonatomic, weak) id<CustomSectionHeaderViewDelegate> delegate;

/**
 セクションのタイトルを指定して初期化

 @param title セクションのタイトル
 @param index セクションのインデックス
 @param isOpen セクションの開閉状態
 */
- (id)initWithTitle:(NSString *)title
       sectionIndex:(NSInteger)index
             isOpen:(BOOL)isOpen;

/**
 セクションのタイトルを設定する
 
 @param title セクションのタイトル
 */
- (void)setTitle:(NSString *)title;

/**
 セクションのインデックスを設定する
 
 @param index セクションのインデックス
 */
- (void)setIndex:(NSInteger)index;

@end
