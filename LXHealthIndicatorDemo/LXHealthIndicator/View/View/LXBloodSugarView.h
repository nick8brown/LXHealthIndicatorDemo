//
//  LXBloodSugarView.h
//  FreelyHeath
//
//  Created by LX Zeng on 2018/8/21.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DYScrollRulerView.h"

#define bloodSugarView_WIDTH kScreen_WIDTH
#define bloodSugarView_HEIGHT 363

typedef void(^MarkBtnBlock)(UIButton *sender);

@interface LXBloodSugarView : UIView <DYScrollRulerDelegate>

@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UILabel *sugarLabel;
@property (weak, nonatomic) IBOutlet UIView *selectSugarView;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;

@property (nonatomic, strong) DYScrollRulerView *rulerView;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) CGFloat sugar;
@property (nonatomic, copy) MarkBtnBlock markBtnBlock;

+ (instancetype)bloodSugarView;
+ (instancetype)bloodSugarViewWithFrame:(CGRect)frame;

@end
