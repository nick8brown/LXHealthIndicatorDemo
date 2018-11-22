//
//  LXHealthIndicatorTableViewCell.h
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/17.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import <UIKit/UIKit.h>

#define LXHealthIndicatorTableViewCell_HEIGHT 71

typedef void(^AddHealthIndicatorBtnBlock)(NSString *type);

@class LXHealthIndicatorItem;

@interface LXHealthIndicatorTableViewCell : UITableViewCell

// 健康指标记录
@property (nonatomic, strong) LXHealthIndicatorItem *item;

@property (nonatomic, copy) AddHealthIndicatorBtnBlock addHealthIndicatorBtnBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (instancetype)initWithTableView:(UITableView *)tableView;

@end
