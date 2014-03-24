//
//  ViewController.m
//  UITableViewAccordionSection
//
//  Created by Yoshiaki Itakura on 2014/03/24.
//  Copyright (c) 2014年 Yoshiaki Itakura. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *sectionList_;
    NSMutableArray *sectionStateList_;
    NSMutableArray *contentsList_;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

/**
 セクション数を返す
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionList_ count];
}

/**
 セクション毎のセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // セクションが閉じている場合は0を返す
    BOOL isOpen = [[sectionStateList_ objectAtIndex:section] boolValue];
    return isOpen ? [[contentsList_ objectAtIndex:section] count] : 0;
}

/**
 セルのコンテンツを設定する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *content = [[contentsList_ objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = content;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

/**
 セクションヘッダーの高さを返す
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isHideSection) {
        return 0.0f;
    }
    return 40.0f;
}

/**
 セクションヘッダーのコンテンツを設定する
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.isHideSection) {
        return nil;
    }
    NSString *title = [sectionList_ objectAtIndex:section];
    BOOL isOpen = [self isEmptyList:sectionStateList_] ? YES : [[sectionStateList_ objectAtIndex:section] boolValue];
    CustomSectionHeaderView *containerView = [[CustomSectionHeaderView alloc] initWithTitle:title
                                                                               sectionIndex:section
                                                                                     isOpen:isOpen];
    containerView.delegate = self;
    
    return containerView;
}

/**
 セルタップ時に実行される処理
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 今回は何もしない
}

#pragma mark - CustomSectionHeaderViewDelegate

/**
 シングルタップ時に実行される処理
 
 @param sectionIndex セクションのインデックス
 @param isOpen セクションの開閉状態
 */
- (void)didSectionHeaderSingleTap:(NSInteger)sectionIndex isOpen:(BOOL)isOpen
{
    [sectionStateList_ replaceObjectAtIndex:sectionIndex
                                 withObject:[NSNumber numberWithBool:isOpen]];
    [self.tableView beginUpdates];

    if (isOpen) {
        [self openSectionContents:sectionIndex];
    } else {
        [self closeSectionContents:sectionIndex];
    }
    
    [self.tableView endUpdates];
}

#pragma mark - Private Methods

/**
 データ読み込み
 */
- (void)loadList
{
    if ([self isEmptyList:sectionList_]) {
        sectionList_ = @[@"Section1", @"Section2", @"Section3"];
        if ([self isEmptyList:sectionStateList_]) {
            NSNumber *yes = [NSNumber numberWithBool:YES];
            sectionStateList_ = [NSMutableArray arrayWithArray:@[yes, yes, yes]];
        }
        contentsList_ = [NSMutableArray array];
        [contentsList_ addObject:@[@"Section1_Content1", @"Section1_Content2", @"Section1_Content3"]];
        [contentsList_ addObject:@[@"Section2_Content1", @"Section2_Content2", @"Section2_Content3"]];
        [contentsList_ addObject:@[@"Section3_Content1", @"Section3_Content2", @"Section3_Content3"]];
    }
}

/**
 指定セクション配下のコンテンツを開く
 
 @param sectionIndex セクションのインデックス
 */
- (void)openSectionContents:(NSInteger)sectionIndex
{
    NSArray *openSection = [contentsList_ objectAtIndex:sectionIndex];
    NSInteger cnt = [openSection count];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:cnt];
    int index = 0;
    for (int i = 0; i < cnt; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
        index++;
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

/**
 指定セクション配下のコンテンツを閉じる
 
 @param sectionIndex セクションのインデックス
 */
- (void)closeSectionContents:(NSInteger)sectionIndex
{
    NSArray *closeSection = [contentsList_ objectAtIndex:sectionIndex];
    NSInteger cnt = [closeSection count];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:cnt];
    for (int i = 0; i < cnt; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sectionIndex]];
    }
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

/**
 リストのチェック
 nil or 要素数0以下の場合はYES
 */
- (BOOL)isEmptyList:(NSArray *)array
{
    return (array == nil || [array count] <= 0);
}

@end
