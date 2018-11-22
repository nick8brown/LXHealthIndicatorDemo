//
//  LXHealthIndicatorViewController.m
//  LXHealthIndicatorDemo
//
//  Created by LX Zeng on 2018/11/22.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXHealthIndicatorViewController.h"
#import "LXHealthIndicatorViewModel.h"

#import "LXHealthIndicatorView.h"
#import "LXBloodPressureView.h"
#import "LXBloodSugarView.h"
#import "LXHealthIndicatorTableViewCell.h"

#import "LXIndicatorTypeViewController.h"

@interface LXHealthIndicatorViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic, strong) LXHealthIndicatorView *heightView;
@property (nonatomic, strong) LXHealthIndicatorView *weightView;
@property (nonatomic, strong) LXBloodPressureView *bloodPressureView;
@property (nonatomic, strong) LXBloodSugarView *bloodSugarView;
@property (nonatomic, strong) LXHealthIndicatorView *waistlineView;
@property (nonatomic, strong) LXHealthIndicatorView *bodyFatRateView;
@property (nonatomic, strong) LXHealthIndicatorView *BMIView;
@property (nonatomic, strong) NSArray *healthIndicatorViewArray;
@property (nonatomic, strong) NSArray *numArray;
@property (nonatomic, strong) NSArray *timesectionArray;

@property (nonatomic, strong) LXHealthIndicatorViewModel *allIndicatorViewModel;
@property (nonatomic, strong) LXHealthIndicatorViewModel *addIndicatorViewModel;

@property (nonatomic, strong) NSArray *healthIndicatorItems;
@property (nonatomic, strong) NSArray *healthIndicatorRecordItems;

@end

@implementation LXHealthIndicatorViewController

#pragma mark - lazy load
- (LXHealthIndicatorView *)heightView {
    if (!_heightView) {
        _heightView = [LXHealthIndicatorView healthIndicatorViewWithFrame:CGRectMake(0, kScreen_HEIGHT, healthIndicatorView_WIDTH, healthIndicatorView_HEIGHT)];
        _heightView.healthIndicatorType = LXHealthIndicatorType_Height;
        _heightView.tag = BASE_TAG + 0;
        _heightView.markBtn.tag = _heightView.tag;
        __weak __typeof(self) weakSelf = self;
        _heightView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
        
        [_heightView setupRulerView];
    }
    return _heightView;
}

- (LXHealthIndicatorView *)weightView {
    if (!_weightView) {
        _weightView = [LXHealthIndicatorView healthIndicatorViewWithFrame:CGRectMake(0, kScreen_HEIGHT, healthIndicatorView_WIDTH, healthIndicatorView_HEIGHT)];
        _weightView.healthIndicatorType = LXHealthIndicatorType_Weight;
        _weightView.tag = BASE_TAG + 1;
        _weightView.markBtn.tag = _weightView.tag;
        __weak __typeof(self) weakSelf = self;
        _weightView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
        
        [_weightView setupRulerView];
    }
    return _weightView;
}

- (LXBloodPressureView *)bloodPressureView {
    if (!_bloodPressureView) {
        _bloodPressureView = [LXBloodPressureView bloodPressureViewWithFrame:CGRectMake(0, kScreen_HEIGHT, bloodPressureView_WIDTH, bloodPressureView_HEIGHT)];
        _bloodPressureView.tag = BASE_TAG + 2;
        _bloodPressureView.markBtn.tag = _bloodPressureView.tag;
        __weak __typeof(self) weakSelf = self;
        _bloodPressureView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
    }
    return _bloodPressureView;
}

- (LXBloodSugarView *)bloodSugarView {
    if (!_bloodSugarView) {
        _bloodSugarView = [LXBloodSugarView bloodSugarViewWithFrame:CGRectMake(0, kScreen_HEIGHT, bloodSugarView_WIDTH, bloodSugarView_HEIGHT)];
        _bloodSugarView.tag = BASE_TAG + 3;
        _bloodSugarView.markBtn.tag = _bloodSugarView.tag;
        __weak __typeof(self) weakSelf = self;
        _bloodSugarView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
    }
    return _bloodSugarView;
}

- (LXHealthIndicatorView *)waistlineView {
    if (!_waistlineView) {
        _waistlineView = [LXHealthIndicatorView healthIndicatorViewWithFrame:CGRectMake(0, kScreen_HEIGHT, healthIndicatorView_WIDTH, healthIndicatorView_HEIGHT)];
        _waistlineView.healthIndicatorType = LXHealthIndicatorType_Waistline;
        _waistlineView.tag = BASE_TAG + 4;
        _waistlineView.markBtn.tag = _waistlineView.tag;
        __weak __typeof(self) weakSelf = self;
        _waistlineView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
        
        [_waistlineView setupRulerView];
    }
    return _waistlineView;
}

- (LXHealthIndicatorView *)bodyFatRateView {
    if (!_bodyFatRateView) {
        _bodyFatRateView = [LXHealthIndicatorView healthIndicatorViewWithFrame:CGRectMake(0, kScreen_HEIGHT, healthIndicatorView_WIDTH, healthIndicatorView_HEIGHT)];
        _bodyFatRateView.healthIndicatorType = LXHealthIndicatorType_BodyFatRate;
        _bodyFatRateView.tag = BASE_TAG + 5;
        _bodyFatRateView.markBtn.tag = _bodyFatRateView.tag;
        __weak __typeof(self) weakSelf = self;
        _bodyFatRateView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
        
        [_bodyFatRateView setupRulerView];
    }
    return _bodyFatRateView;
}

- (LXHealthIndicatorView *)BMIView {
    if (!_BMIView) {
        _BMIView = [LXHealthIndicatorView healthIndicatorViewWithFrame:CGRectMake(0, kScreen_HEIGHT, healthIndicatorView_WIDTH, healthIndicatorView_HEIGHT)];
        _BMIView.healthIndicatorType = LXHealthIndicatorType_BMI;
        _BMIView.tag = BASE_TAG + 6;
        _BMIView.markBtn.tag = _BMIView.tag;
        __weak __typeof(self) weakSelf = self;
        _BMIView.markBtnBlock = ^(UIButton *sender) {
            // 记录
            [weakSelf markBtnClick:sender];
        };
        
        [_BMIView setupRulerView];
    }
    return _BMIView;
}

- (NSArray *)healthIndicatorViewArray {
    if (!_healthIndicatorViewArray) {
        _healthIndicatorViewArray = @[self.heightView, self.weightView, self.bloodPressureView, self.bloodSugarView, self.waistlineView, self.bodyFatRateView, self.BMIView];
    }
    return _healthIndicatorViewArray;
}

- (NSArray *)numArray {
    NSString *height = [NSString stringWithFormat:@"%.0f", self.heightView.indicator];
    NSString *weight = [NSString stringWithFormat:@"%.1f", self.weightView.indicator];
    NSString *bloodPressure = [NSString stringWithFormat:@"%.0f/%.0f", self.bloodPressureView.systolicPressure, self.bloodPressureView.diastolicPressure];
    NSString *bloodSugar = [NSString stringWithFormat:@"%.1f", self.bloodSugarView.sugar];
    NSString *waistline = [NSString stringWithFormat:@"%.0f", self.waistlineView.indicator];
    NSString *bodyFatRate = [NSString stringWithFormat:@"%.1f", self.bodyFatRateView.indicator];
    NSString *BMI = [NSString stringWithFormat:@"%.1f", self.BMIView.indicator];
    _numArray = @[height, weight, bloodPressure, bloodSugar, waistline, bodyFatRate, BMI];
    return _numArray;
}

- (NSArray *)timesectionArray {
    _timesectionArray = @[@"", @"", @"", [NSString stringWithFormat:@"%@", self.bloodSugarView.time], @"", @"", @""];
    return _timesectionArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"健康指标";
    
    // 初始化导航栏
    [self setupNavBar];
    
    // 绑定viewModel
    [self bindViewModel];

    // 初始化healthIndicatorView
    [self setupHealthIndicatorView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 绑定viewModel
- (void)bindViewModel {
    // 1.绑定健康指标viewModel
    [self bindAllIndicatorViewModel];
    
    // 2.绑定添加健康指标viewModel
    [self bindAddIndicatorViewModel];
}

// 1.绑定健康指标viewModel
- (void)bindAllIndicatorViewModel {
    _allIndicatorViewModel = [[LXHealthIndicatorViewModel alloc] initWithSuccessBlock:^(id data) {
        NSLog(@"-----【我的】-----【健康指标】-----【成功】-----");
        NSLog(@"%@", data);
        
        self.healthIndicatorItems = [NSArray arrayWithArray:[data firstObject]];
        self.healthIndicatorRecordItems = [NSArray arrayWithArray:[data lastObject]];

        [self.tableView reloadData];
    } errorBlock:^(NSInteger code) {
    } failureBlock:^(NSError *error) {
        NSLog(@"-----【我的】-----【健康指标】-----【失败】-----");
        NSLog(@"%@", error);
    }];
    
    // 加载健康指标数据
    [self loadHealthIndicatorData];
}

// 加载健康指标数据
- (void)loadHealthIndicatorData {
    _allIndicatorViewModel.type = LXHealthIndicatorViewModelType_AllIndicator;
    
    // 1.加载健康指标数据
    [_allIndicatorViewModel loadHealthIndicatorData];
}

// 2.绑定添加健康指标viewModel
- (void)bindAddIndicatorViewModel {
    _addIndicatorViewModel = [[LXHealthIndicatorViewModel alloc] initWithSuccessBlock:^(id data) {
        NSLog(@"-----【我的】-----【添加健康指标】-----【成功】-----");
        NSLog(@"%@", data);
        
        self.healthIndicatorItems = [NSArray arrayWithArray:[data firstObject]];
        self.healthIndicatorRecordItems = [NSArray arrayWithArray:[data lastObject]];

        [self.tableView reloadData];
    } errorBlock:^(NSInteger code) {
    } failureBlock:^(NSError *error) {
        NSLog(@"-----【我的】-----【添加健康指标】-----【失败】-----");
        NSLog(@"%@", error);
    }];
}

// 加载添加健康指标数据
- (void)loadAddIndicatorDataWithCode:(NSString *)code name:(NSString *)name unit:(NSString *)unit num:(NSString *)num timesection:(NSString *)timesection {
    _addIndicatorViewModel.type = LXHealthIndicatorViewModelType_AddIndicator;
    
    LXHealthIndicatorItem *item = [[LXHealthIndicatorItem alloc] init];
    item.code = code;
    item.name = name;
    item.unit = unit;
    item.num = num;
    item.timesection = timesection;
    
    // 1.加载添加健康指标数据
    [_addIndicatorViewModel loadAddHealthIndicatorData:item];
}

#pragma mark - 初始化healthIndicatorView
- (void)setupHealthIndicatorView {
    // 初始化tableView
    [self setupTableView];
}

// 初始化tableView
- (void)setupTableView {
    // 设置tableView
    self.tableView.rowHeight = LXHealthIndicatorTableViewCell_HEIGHT;
    RegisterNib_for_Cell(LXHealthIndicatorTableViewCell);
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.healthIndicatorItems.count;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXHealthIndicatorItem *item = self.healthIndicatorItems[indexPath.section];
    
    LXHealthIndicatorTableViewCell *cell = [LXHealthIndicatorTableViewCell cellWithTableView:tableView];
    cell.addHealthIndicatorBtnBlock = ^(NSString *type) {
        [self addHealthIndicator:item.code];
    };
    cell.item = item;
    return cell;
}

#pragma mark - UITableViewDelegate
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 7.5;
    }
    return 3;
}

// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = AppHTMLColor(@"f4f4f4");
    return headerView;
}

// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

// 选中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LXHealthIndicatorItem *item = self.healthIndicatorItems[indexPath.section];
    
    LXIndicatorTypeViewController *indicatorTypeVC = [[LXIndicatorTypeViewController alloc] initWithNibName:@"LXIndicatorTypeViewController" bundle:[NSBundle mainBundle]];
    indicatorTypeVC.title = item.name;
    indicatorTypeVC.code = item.code;
    indicatorTypeVC.healthIndicatorRecordItems = self.healthIndicatorRecordItems[[item.code integerValue]-1];
    [self.navigationController pushViewController:indicatorTypeVC animated:YES];
}

#pragma mark - 添加健康指标
- (void)addHealthIndicator:(NSString *)type {
    NSInteger index = [type integerValue] - 1;
    [self maskView:self.maskView showBottomMenuView:self.healthIndicatorViewArray[index]];
}

#pragma mark - 移除maskView
- (IBAction)onTapToHideMaskView:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag - BASE_TAG;
    [self maskView:self.maskView hideBottomMenuView:self.healthIndicatorViewArray[index]];
}

#pragma mark - View Block 调用
// 记录
- (void)markBtnClick:(UIButton *)sender {
    NSInteger index = sender.tag - BASE_TAG;
    [self maskView:self.maskView hideBottomMenuView:self.healthIndicatorViewArray[index]];
    
    // 加载添加健康指标数据
    [self loadAddIndicatorDataWithCode:[NSString stringWithFormat:@"%zd", index+1] name:nameArray[index] unit:unitArray[index] num:self.numArray[index] timesection:self.timesectionArray[index]];
}

#pragma mark - 底部菜单弹框
// 显示
- (void)maskView:(UIView *)maskView showBottomMenuView:(UIView *)menuView {
    [self.view addSubview:menuView];
    CGRect rect = menuView.frame;
    CGRect newRect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect)-CGRectGetHeight(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    [UIView animateWithDuration:0.3 animations:^{
        menuView.frame = newRect;
        
        maskView.hidden = NO;
        maskView.alpha = 0.4;
    } completion:^(BOOL finished) {
        maskView.tag = menuView.tag;
    }];
}

// 隐藏
- (void)maskView:(UIView *)maskView hideBottomMenuView:(UIView *)menuView {
    CGRect rect = menuView.frame;
    CGRect newRect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect)+CGRectGetHeight(rect), CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    [UIView animateWithDuration:0.3 animations:^{
        menuView.frame = newRect;
        
        maskView.alpha = 0;
    } completion:^(BOOL finished) {
        maskView.hidden = YES;
        
        [menuView removeFromSuperview];
    }];
}

@end
