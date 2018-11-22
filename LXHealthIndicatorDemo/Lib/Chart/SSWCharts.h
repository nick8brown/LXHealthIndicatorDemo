//
//  SSWCharts.h
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018 com.sswang.www. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SSWChartsType){
    SSWChartsTypePie,
    SSWChartsTypeLine,
    SSWChartsTypeBar
};
@protocol SSWChartsDelegate;
@interface SSWCharts : UIView
-(instancetype)initWithChartType:(SSWChartsType)type;
@property(nonatomic,assign)SSWChartsType        chartType;
@property(nonatomic,strong)NSArray              *percentageArr;//百分比数组 对应piechart
@property(nonatomic)NSArray                     *colorsArr;//颜色组数 对应piechart
@property(nonatomic)NSArray                     *titlesArr;//标题数组 对应piechart

@property(nonatomic)UILabel                     *bubbleLab;//点击时提示泡泡
@property(nonatomic,assign)BOOL                 showEachYValus;//是否显示每个Y值

@property(nonatomic,assign)id<SSWChartsDelegate>delegate;
-(CABasicAnimation *)animationWithDuration:(CFTimeInterval)duration;
@end
@protocol SSWChartsDelegate<NSObject>
//
@optional
-(void)SSWChartView:(SSWCharts *)chartView didSelectIndex:(NSInteger)index;
//
-(void)SSWChartView:(SSWCharts *)chartView didSelectMutipleBarChartIndex:(NSArray *)index;
@end
