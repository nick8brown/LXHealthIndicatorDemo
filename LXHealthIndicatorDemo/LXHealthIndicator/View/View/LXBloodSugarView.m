//
//  LXBloodSugarView.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/21.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXBloodSugarView.h"

@implementation LXBloodSugarView

#pragma mark - lazy load
- (DYScrollRulerView *)rulerView {
    if (!_rulerView) {
        _rulerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_WIDTH-2*30, [DYScrollRulerView rulerViewHeight]) theMinValue:0 theMaxValue:25  theStep:0.1 theUnit:@"" theNum:10];
        [_rulerView setDefaultValue:5.5 animated:YES];
//        _rulerView.bgColor = SYS_White_Color;
//        _rulerView.triangleColor = AppMainThemeColor;
        _rulerView.delegate = self;
        _rulerView.scrollByHand = YES;
        
        self.sugar = 5.5;
    }
    return _rulerView;
}

#pragma mark - private func
+ (instancetype)bloodSugarView {
    LXBloodSugarView *bloodSugarView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    [bloodSugarView setupBtnView];
    [bloodSugarView setupRulerView];
    return bloodSugarView;
}

+ (instancetype)bloodSugarViewWithFrame:(CGRect)frame {
    LXBloodSugarView *bloodSugarView = [self bloodSugarView];
    bloodSugarView.frame = frame;
    return bloodSugarView;
}

- (void)setupBtnView {
    for (UIButton *btn in self.btnView.subviews) {
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (btn.tag == BASE_TAG+9) {
            [self selectBtnClick:btn];
        }
    }
}

- (void)setupRulerView {
    [self.selectSugarView addSubview:self.rulerView];
}

#pragma mark - DYScrollRulerDelegate
- (void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value {
    self.sugarLabel.text = [NSString stringWithFormat:@"%.1fmmol/l", value];
    self.sugar = value;
}

#pragma mark - 记录
- (IBAction)markBtnClick:(UIButton *)sender {
    if (self.markBtnBlock) {
        self.markBtnBlock(sender);
    }
}

#pragma mark - 监听按钮点击事件
// 选中
- (void)selectBtnClick:(UIButton *)sender {
    for (UIButton *btn in self.btnView.subviews) {
        if (btn.tag == sender.tag) {
            [self setSelectedBtn:btn];
        } else {
            [self setNormalBtn:btn];
        }
    }
}

- (void)setNormalBtn:(UIButton *)btn {
    [btn setTitleColor:AppHTMLColor(@"666666") forState:UIControlStateNormal];
}

- (void)setSelectedBtn:(UIButton *)btn {
    [btn setTitleColor:AppHTMLColor(@"4bccbc") forState:UIControlStateNormal];
    
    self.time = btn.currentTitle;
}

@end
