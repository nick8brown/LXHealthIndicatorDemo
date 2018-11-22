//
//  LXBloodPressureView.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/21.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXBloodPressureView.h"

@implementation LXBloodPressureView

#pragma mark - lazy load
- (DYScrollRulerView *)systolicPressureRulerView {
    if (!_systolicPressureRulerView) {
        _systolicPressureRulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:300  theStep:1 theUnit:@"" theNum:10];
        [_systolicPressureRulerView setDefaultValue:120 animated:YES];
//        _systolicPressureRulerView.bgColor = SYS_White_Color;
//        _systolicPressureRulerView.triangleColor = AppMainThemeColor;
        _systolicPressureRulerView.delegate = self;
        _systolicPressureRulerView.scrollByHand = YES;
        
        self.systolicPressure = 120;
    }
    return _systolicPressureRulerView;
}

- (DYScrollRulerView *)diastolicPressureRulerView {
    if (!_diastolicPressureRulerView) {
        _diastolicPressureRulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:300  theStep:1 theUnit:@"" theNum:10];
        [_diastolicPressureRulerView setDefaultValue:75 animated:YES];
//        _diastolicPressureRulerView.bgColor = SYS_White_Color;
//        _diastolicPressureRulerView.triangleColor = AppMainThemeColor;
        _diastolicPressureRulerView.delegate = self;
        _diastolicPressureRulerView.scrollByHand = YES;
        
        self.diastolicPressure = 75;
    }
    return _diastolicPressureRulerView;
}

#pragma mark - private func
+ (instancetype)bloodPressureView {
    LXBloodPressureView *bloodPressureView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    [bloodPressureView setupRulerView];
    return bloodPressureView;
}

+ (instancetype)bloodPressureViewWithFrame:(CGRect)frame {
    LXBloodPressureView *bloodPressureView = [self bloodPressureView];
    bloodPressureView.frame = frame;
    return bloodPressureView;
}

- (void)setupRulerView {
    [self.selectSystolicPressureView addSubview:self.systolicPressureRulerView];
    [self.selectDiastolicPressureView addSubview:self.diastolicPressureRulerView];
}

#pragma mark - DYScrollRulerDelegate
- (void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value {
    if (rulerView == self.systolicPressureRulerView) {
        self.systolicPressureLabel.text = [NSString stringWithFormat:@"%.0fmmHg", value];
        self.systolicPressure = value;
    } else if (rulerView == self.diastolicPressureRulerView) {
        self.diastolicPressureLabel.text = [NSString stringWithFormat:@"%.0fmmHg", value];
        self.diastolicPressure = value;
    }
}

#pragma mark - 记录
- (IBAction)markBtnClick:(UIButton *)sender {
    if (self.markBtnBlock) {
        self.markBtnBlock(sender);
    }
}

@end
