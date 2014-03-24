//
//  ViewController.h
//  UITableViewAccordionSection
//
//  Created by Yoshiaki Itakura on 2014/03/24.
//  Copyright (c) 2014年 Yoshiaki Itakura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSectionHeaderView.h"

@interface ViewController : UITableViewController<CustomSectionHeaderViewDelegate>

@property (nonatomic) BOOL isHideSection;

@end
