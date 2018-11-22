//
//  SSWMutipleBarChartView.h
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/7.
//  Copyright © 2018 com.sswang.www. All rights reserved.
//

#import "SSWCharts.h"

@interface SSWMutipleBarChartView : SSWCharts
@property(nonatomic)NSMutableArray      *xValuesArr;
@property(nonatomic)NSMutableArray      *yValuesArr;
@property(nonatomic)NSMutableArray      *barColorArr;
@property(nonatomic,assign)CGFloat      barWidth;
@property(nonatomic,assign)CGFloat      gapWidth;
@property(nonatomic,assign)NSInteger    yAxiasCount;
@property(nonatomic,assign)NSInteger    yAxiasValus;
@property(nonatomic,copy)NSString       *unit;
@property(nonatomic)NSMutableArray      *legendTitlesArr;
@end
