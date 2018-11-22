//
//  LXBloodPressureView.h
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/21.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DYScrollRulerView.h"

#define bloodPressureView_WIDTH kScreen_WIDTH
#define bloodPressureView_HEIGHT 395

typedef void(^MarkBtnBlock)(UIButton *sender);

@interface LXBloodPressureView : UIView <DYScrollRulerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *systolicPressureLabel;
@property (weak, nonatomic) IBOutlet UIView *selectSystolicPressureView;
@property (weak, nonatomic) IBOutlet UILabel *diastolicPressureLabel;
@property (weak, nonatomic) IBOutlet UIView *selectDiastolicPressureView;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (nonatomic, strong) DYScrollRulerView *systolicPressureRulerView;
@property (nonatomic, strong) DYScrollRulerView *diastolicPressureRulerView;
@property (nonatomic, assign) CGFloat systolicPressure;
@property (nonatomic, assign) CGFloat diastolicPressure;
@property (nonatomic, copy) MarkBtnBlock markBtnBlock;

+ (instancetype)bloodPressureView;
+ (instancetype)bloodPressureViewWithFrame:(CGRect)frame;

@end
