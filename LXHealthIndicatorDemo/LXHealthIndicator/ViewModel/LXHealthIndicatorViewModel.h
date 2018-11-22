//
//  LXHealthIndicatorViewModel.h
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/29.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXHealthIndicatorItem.h"

#define typeCount 7
#define nameArray @[@"身高", @"体重", @"血压", @"血糖", @"腹围", @"体脂肪率", @"BMI"]
#define unitArray @[@"cm", @"kg", @"mmHg", @"mmol/l", @"cm", @"%", @""]

typedef void(^SuccessBlock)(id data);
typedef void(^ErrorBlock)(NSInteger code);
typedef void(^FailureBlock)(NSError *error);

typedef enum {
    LXHealthIndicatorViewModelType_AllIndicator = 0, // 获取健康指标信息
    LXHealthIndicatorViewModelType_AddIndicator, // 保存健康指标信息
} LXHealthIndicatorViewModelType;

@interface LXHealthIndicatorViewModel : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) ErrorBlock errorBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

@property (nonatomic, assign) LXHealthIndicatorViewModelType type;

// 数据源（健康指标）
@property (nonatomic, strong) NSMutableArray *healthIndicatorItems;

// 数据源（健康指标记录）
@property (nonatomic, strong) NSMutableArray *healthIndicatorRecordItems;

- (instancetype)initWithSuccessBlock:(SuccessBlock)successBlock errorBlock:(ErrorBlock)errorBlock failureBlock:(FailureBlock)failureBlock;

- (void)loadHealthIndicatorData;
- (void)loadAddHealthIndicatorData:(LXHealthIndicatorItem *)item;

@end
