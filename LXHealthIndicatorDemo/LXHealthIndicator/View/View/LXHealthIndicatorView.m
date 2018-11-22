//
//  LXHealthIndicatorView.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/17.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXHealthIndicatorView.h"

@implementation LXHealthIndicatorView

#pragma mark - lazy load
- (DYScrollRulerView *)rulerView {
    if (!_rulerView) {
        _rulerView = [self setRulerView];
    }
    return _rulerView;
}

- (DYScrollRulerView *)setRulerView {
    DYScrollRulerView *rulerView = nil;
    switch (self.healthIndicatorType) {
        case LXHealthIndicatorType_Height:
        {
            rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:300  theStep:1 theUnit:@"" theNum:10];
            [rulerView setDefaultValue:170 animated:YES];
//            rulerView.bgColor = SYS_White_Color;
//            rulerView.triangleColor = AppMainThemeColor;
            rulerView.delegate = self;
            rulerView.scrollByHand = YES;
            
            self.nameLabel.text = @"身高";
            [self updateRulerView:170];
        }
            break;
        case LXHealthIndicatorType_Weight:
        {
            rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:300  theStep:0.1 theUnit:@"" theNum:10];
            [rulerView setDefaultValue:70 animated:YES];
//            rulerView.bgColor = SYS_White_Color;
//            rulerView.triangleColor = AppMainThemeColor;
            rulerView.delegate = self;
            rulerView.scrollByHand = YES;

            self.nameLabel.text = @"体重";
            [self updateRulerView:70];
        }
            break;
        case LXHealthIndicatorType_Waistline:
        {
            rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:300  theStep:1 theUnit:@"" theNum:10];
            [rulerView setDefaultValue:90 animated:YES];
//            rulerView.bgColor = SYS_White_Color;
//            rulerView.triangleColor = AppMainThemeColor;
            rulerView.delegate = self;
            rulerView.scrollByHand = YES;
            
            self.nameLabel.text = @"腹围";
            [self updateRulerView:90];
        }
            break;
        case LXHealthIndicatorType_BodyFatRate:
        {
            rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:100  theStep:0.1 theUnit:@"" theNum:10];
            [rulerView setDefaultValue:15 animated:YES];
//            rulerView.bgColor = SYS_White_Color;
//            rulerView.triangleColor = AppMainThemeColor;
            rulerView.delegate = self;
            rulerView.scrollByHand = YES;
            
            self.nameLabel.text = @"体脂肪率";
            [self updateRulerView:15];
        }
            break;
        case LXHealthIndicatorType_BMI:
        {
            rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:100  theStep:0.1 theUnit:@"" theNum:10];
            [rulerView setDefaultValue:23 animated:YES];
//            rulerView.bgColor = SYS_White_Color;
//            rulerView.triangleColor = AppMainThemeColor;
            rulerView.delegate = self;
            rulerView.scrollByHand = YES;
            
            self.nameLabel.text = @"BMI";
            [self updateRulerView:23];
        }
            break;
    }
    return rulerView;
}

#pragma mark - private func
+ (instancetype)healthIndicatorView {
    LXHealthIndicatorView *healthIndicatorView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    return healthIndicatorView;
}

+ (instancetype)healthIndicatorViewWithFrame:(CGRect)frame {
    LXHealthIndicatorView *healthIndicatorView = [self healthIndicatorView];
    healthIndicatorView.frame = frame;
    return healthIndicatorView;
}

- (void)setupRulerView {
    [self.selectIndicatorView addSubview:self.rulerView];
}

#pragma mark - DYScrollRulerDelegate
- (void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value {
    [self updateRulerView:value];
}

- (void)updateRulerView:(float)value {
    NSString *indicator = nil;
    switch (self.healthIndicatorType) {
        case LXHealthIndicatorType_Height:
        {
            indicator = [NSString stringWithFormat:@"%.0fcm", value];
        }
            break;
        case LXHealthIndicatorType_Weight:
        {
            indicator = [NSString stringWithFormat:@"%.1fkg", value];
        }
            break;
        case LXHealthIndicatorType_Waistline:
        {
            indicator = [NSString stringWithFormat:@"%.0fcm", value];
        }
            break;
        case LXHealthIndicatorType_BodyFatRate:
        {
            indicator = [NSString stringWithFormat:@"%.1f%%", value];
        }
            break;
        case LXHealthIndicatorType_BMI:
        {
            indicator = [NSString stringWithFormat:@"%.1f", value];
        }
            break;
    }

    self.indicatorLabel.text = indicator;
    self.indicator = value;
}

#pragma mark - 记录
- (IBAction)markBtnClick:(UIButton *)sender {
    if (self.markBtnBlock) {
        self.markBtnBlock(sender);
    }
}

@end
