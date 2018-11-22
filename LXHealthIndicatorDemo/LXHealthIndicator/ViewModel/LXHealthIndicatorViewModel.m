//
//  LXHealthIndicatorViewModel.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/29.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXHealthIndicatorViewModel.h"

#define numArray @[@"170", @"70", @"120/75", @"5.5", @"90", @"15", @"23"]
#define timesectionArray @[@"", @"", @"", @"空腹", @"", @"", @""]

@implementation LXHealthIndicatorViewModel

- (instancetype)initWithSuccessBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock failureBlock:(FailureBlock)failureBlock {
    self = [super init];
    if (self) {
        _successBlock = successBlock;
        _errorBlock = errorBlock;
        _failureBlock = failureBlock;
    }
    return self;
}

#pragma mark - lazy load
- (NSMutableArray *)healthIndicatorItems {
    if (!_healthIndicatorItems) {
        _healthIndicatorItems = [NSMutableArray array];
        for (int i = 0; i < typeCount; i++) {
            LXHealthIndicatorItem *item = [[LXHealthIndicatorItem alloc] init];
            item.code = [NSString stringWithFormat:@"%d", i+1];
            item.name = nameArray[i];
            item.num = numArray[i];
            item.unit = unitArray[i];
            item.createtime = [NSString getCurrentTimeWithDateFormat:YEAR_MONTH_DAY_HOUR_MINUTE_SECOND];
            item.timesection = timesectionArray[i];
            [_healthIndicatorItems addObject:item];
        }
    }
    return _healthIndicatorItems;
}

- (NSMutableArray *)healthIndicatorRecordItems {
    if (!_healthIndicatorRecordItems) {
        _healthIndicatorRecordItems = [NSMutableArray array];
        for (int i = 0; i < typeCount; i++) {
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObject:self.healthIndicatorItems[i]];
            [_healthIndicatorRecordItems addObject:tempArray];
        }
    }
    return _healthIndicatorRecordItems;
}

#pragma mark - 数据请求
- (void)loadHealthIndicatorData {
    // 处理数据
    [self handleJSONDict];
}

- (void)loadAddHealthIndicatorData:(LXHealthIndicatorItem *)item {
    NSInteger type = [item.code integerValue] - 1;
    
    NSMutableArray *array = self.healthIndicatorRecordItems[type];
    [array addObject:item];
    
    [self.healthIndicatorItems replaceObjectAtIndex:type withObject:item];
    
    // 处理数据
    [self handleJSONDict];
}

#pragma mark - 数据处理
- (void)handleJSONDict {
    switch (self.type) {
        case LXHealthIndicatorViewModelType_AllIndicator:
        {
            for (int i = 0; i < self.healthIndicatorItems.count; i++) {
                LXHealthIndicatorItem *item = self.healthIndicatorItems[i];
                NSLog(@"_____1_____%@_____%@_____%@_____%@_____%@", item.code, item.name, item.unit, item.num, item.timesection);
            }

            self.successBlock(@[self.healthIndicatorItems, self.healthIndicatorRecordItems]);
        }
            break;
        case LXHealthIndicatorViewModelType_AddIndicator:
        {
            for (int i = 0; i < self.healthIndicatorItems.count; i++) {
                LXHealthIndicatorItem *item = self.healthIndicatorItems[i];
                NSLog(@"_____2_____%@_____%@_____%@_____%@_____%@", item.code, item.name, item.unit, item.num, item.timesection);
            }

            self.successBlock(@[self.healthIndicatorItems, self.healthIndicatorRecordItems]);
        }
            break;
    }
}

@end
