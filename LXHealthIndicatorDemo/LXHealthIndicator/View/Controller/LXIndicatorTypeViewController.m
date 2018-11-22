//
//  LXIndicatorTypeViewController.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/25.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXIndicatorTypeViewController.h"
#import "LXHealthIndicatorItem.h"

#import "SSWLineChartView.h"
#import "SSWMutipleLineChart.h"

#define dataCount ((self.healthIndicatorRecordItems.count <= 7) ? self.healthIndicatorRecordItems.count : 7)

@interface LXIndicatorTypeViewController () <SSWChartsDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (nonatomic, strong) NSMutableArray *chart_xValuesArr;
@property (nonatomic, strong) NSMutableArray *chart_yValuesArr;
@property (nonatomic, strong) NSMutableArray *mutipleChart_xValuesArr;
@property (nonatomic, strong) NSMutableArray *mutipleChart_yValuesArr;
@property (nonatomic, strong) SSWLineChartView *lineChartView;
@property (nonatomic, strong) SSWMutipleLineChart *mutipleLineChartView;

@end

@implementation LXIndicatorTypeViewController

#pragma mark - lazy load
- (NSMutableArray *)chart_xValuesArr {
    _chart_xValuesArr = [NSMutableArray array];
    for (int i = 0; i < dataCount; i++) {
        LXHealthIndicatorItem *item = self.healthIndicatorRecordItems[i];
        NSString *createtime = @"";
        if (item.createtime.length) {
            createtime = [NSString substring:item.createtime WithRange:NSMakeRange(5, 5)];
            createtime = [NSString replaceString:createtime target:@"-" replacement:@"/"];
        }
        [_chart_xValuesArr addObject:createtime];
    }
    return _chart_xValuesArr;
}

- (NSMutableArray *)chart_yValuesArr {
    _chart_yValuesArr = [NSMutableArray array];
    for (int i = 0; i < dataCount; i++) {
        LXHealthIndicatorItem *item = self.healthIndicatorRecordItems[i];
        [_chart_yValuesArr addObject:item.num];
    }
    return _chart_yValuesArr;
}

- (NSMutableArray *)mutipleChart_xValuesArr {
    _mutipleChart_xValuesArr = [NSMutableArray array];
    for (int i = 0; i < dataCount; i++) {
        LXHealthIndicatorItem *item = self.healthIndicatorRecordItems[i];
        NSString *createtime = @"";
        if (item.createtime.length) {
            createtime = [NSString substring:item.createtime WithRange:NSMakeRange(5, 5)];
            createtime = [NSString replaceString:createtime target:@"-" replacement:@"/"];
        }
        [_mutipleChart_xValuesArr addObject:createtime];
    }
    return _mutipleChart_xValuesArr;
}

- (NSMutableArray *)mutipleChart_yValuesArr {
    _mutipleChart_yValuesArr = [NSMutableArray array];
    for (int i = 0; i < dataCount; i++) {
        LXHealthIndicatorItem *item = self.healthIndicatorRecordItems[i];
        [_mutipleChart_yValuesArr addObject:[item.num componentsSeparatedByString:@"/"]];
    }
    return _mutipleChart_yValuesArr;
}

- (SSWLineChartView *)lineChartView {
    _lineChartView = [[SSWLineChartView alloc] initWithChartType:SSWChartsTypeBar];
    _lineChartView.frame = CGRectMake(8, 8, kScreen_WIDTH-2*8, CGRectGetHeight(self.chartView.frame));
    _lineChartView.xValuesArr = [NSMutableArray arrayWithArray:self.chart_xValuesArr];
    _lineChartView.yValuesArr = [NSMutableArray arrayWithArray:self.chart_yValuesArr];
    _lineChartView.unit = @[@"cm", @"kg", @"mmHg", @"mmol/l", @"cm", @"%", @""][[self.code integerValue]-1];
    _lineChartView.yScaleValue = [@[@30, @30, @30, @2.5, @30, @10, @10][[self.code integerValue]-1] floatValue];
    _lineChartView.lineColor = AppHTMLColor(@"4bccbc");
    return _lineChartView;
}

- (SSWMutipleLineChart *)mutipleLineChartView {
    _mutipleLineChartView = [[SSWMutipleLineChart alloc] initWithChartType:SSWChartsTypeBar];
    _mutipleLineChartView.frame = CGRectMake(8, 8, kScreen_WIDTH-2*8, CGRectGetHeight(self.chartView.frame));
    _mutipleLineChartView.xValuesArr = [NSMutableArray arrayWithArray:self.mutipleChart_xValuesArr];
    _mutipleLineChartView.yValuesArr = [NSMutableArray arrayWithArray:self.mutipleChart_yValuesArr];
    _mutipleLineChartView.legendTitlesArr = [NSMutableArray arrayWithArray:@[@"收缩压", @"舒张压"]];
    _mutipleLineChartView.unit = @"mmHg";
    _mutipleLineChartView.yAxiasValus = 30;
    _mutipleLineChartView.barColorArr = [NSMutableArray arrayWithArray:@[AppHTMLColor(@"4bccbc"), AppHTMLColor(@"4b9dcc")]];
    _mutipleLineChartView.delegate = self;
    return _mutipleLineChartView;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化导航栏
    [self setupNavBar];

    // 初始化indicatorTypeView
    [self setupIndicatorTypeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar {
    // leftBarButtonItem（返回）
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setImage:ImageNamed(@"back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(returnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItems = @[returnItem];
}

// 返回
- (void)returnBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化indicatorTypeView
- (void)setupIndicatorTypeView {
    // 初始化labelView
    [self setupLabelView];
    
    // 初始化chartView
    [self setupChartView];
}

// 初始化labelView
- (void)setupLabelView {
    LXHealthIndicatorItem *item = [self.healthIndicatorRecordItems firstObject];
    
    //
    self.nameLabel.text = [NSString stringWithFormat:@"%@指标", self.title];
    
    //
    self.valueLabel.text = [NSString stringWithFormat:@"%@%@%@", item.timesection, item.num, item.unit];

    //
    if (item.createtime.length) {
        self.timeLabel.text = [NSString substring:item.createtime WithRange:NSMakeRange(5, 11)];
    }
}

// 初始化chartView
- (void)setupChartView {
    if (self.chartView.subviews.count) {
        for (UIView *view in self.chartView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    if ([self.code isEqualToString:@"3"]) {
        [self.chartView addSubview:self.mutipleLineChartView];
    } else {
        [self.chartView addSubview:self.lineChartView];
    }
}

@end
