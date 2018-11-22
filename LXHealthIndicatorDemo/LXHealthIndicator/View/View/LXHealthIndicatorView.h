//
//  LXHealthIndicatorView.h
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/17.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DYScrollRulerView.h"

#define healthIndicatorView_WIDTH kScreen_WIDTH
#define healthIndicatorView_HEIGHT 233

typedef void(^MarkBtnBlock)(UIButton *sender);

typedef enum {
    LXHealthIndicatorType_Height = 0, // 身高
    LXHealthIndicatorType_Weight, // 体重
    LXHealthIndicatorType_Waistline, // 腹围
    LXHealthIndicatorType_BodyFatRate, // 体脂肪率
    LXHealthIndicatorType_BMI // BMI
} LXHealthIndicatorType;

@interface LXHealthIndicatorView : UIView <DYScrollRulerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
@property (weak, nonatomic) IBOutlet UIView *selectIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (nonatomic, assign) LXHealthIndicatorType healthIndicatorType;
@property (nonatomic, strong) DYScrollRulerView *rulerView;
@property (nonatomic, assign) CGFloat indicator;
@property (nonatomic, copy) MarkBtnBlock markBtnBlock;

+ (instancetype)healthIndicatorView;
+ (instancetype)healthIndicatorViewWithFrame:(CGRect)frame;

- (void)setupRulerView;

@end
