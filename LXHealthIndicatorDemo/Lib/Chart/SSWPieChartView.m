//
//  SSWPieChartView.m
//  SSWCharts
//
//  Created by WangShaoShuai on 2018/5/2.
//  Copyright © 2018 com.sswang.www. All rights reserved.
//

#import "SSWPieChartView.h"
@interface SSWPieChartView ()
@property(nonatomic,strong)NSMutableArray   *shapLayersArr;//扇形layer数组
@property(nonatomic,strong)NSMutableArray   *pathsArr;//扇形路径数组
@property(nonatomic)CAShapeLayer            *maskLayer;//遮盖动画layer
@property(nonatomic)NSMutableArray          *halfAngleArr;//扇形中心角度数组
@property(nonatomic)NSMutableArray          *titleLabArr;//提示标题数组
@property(nonatomic)NSMutableArray          *polyLineLayerArr;//折线layer数组
@end
@implementation SSWPieChartView
-(instancetype)initWithChartType:(SSWChartsType)type{
    self = [super initWithChartType:type];
    if (self) {
        [self setUp];
    }
    return self;
}
-(void)setRadius:(CGFloat)radius{
    _radius = radius;
}
-(void)setUp{
    self.radius = 80;
  
    if (self.chartType!= SSWChartsTypePie) {
        return;
    }
    self.shapLayersArr = [@[] mutableCopy];
    self.pathsArr = [@[] mutableCopy];
    self.halfAngleArr = [@[] mutableCopy];
    self.titleLabArr = [@[] mutableCopy];
    self.polyLineLayerArr = [@[] mutableCopy];
    [self addTap];
}
-(void)addTap{
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap{
    CGPoint  point = [tap locationInView:self];
    for (UIBezierPath  *path in self.pathsArr) {
        if ([path containsPoint:point]) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(SSWChartView:didSelectIndex:)]) {
                [self.delegate SSWChartView:self didSelectIndex:[self.pathsArr indexOfObject:path]];
            }
        }
        
    }
}
-(void)setPathForShapLayer{
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        CAShapeLayer  *layer =self.shapLayersArr[i];
        UIBezierPath  *path = self.pathsArr[i];
        layer.path = path.CGPath;
    }
}
-(void)addShapLayers{
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        CAShapeLayer   *layer = [CAShapeLayer layer];
        layer.strokeColor = [UIColor clearColor].CGColor;
        layer.fillColor = [self.colorsArr[i] CGColor];
        layer.lineWidth=1;
        layer.lineJoin  = kCALineCapRound;
        layer.lineCap = kCALineJoinRound;
        [self.layer addSublayer:layer];
        [self.shapLayersArr addObject:layer];
    }
}
-(void)addPaths{
    CGPoint   centerPoint =CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat   radius = self.radius;
    float  lastSumPercentage=0;
    float  lastPercentage=0;
    float  totalSumPercentage=0;
    for (int i = 0 ; i<self.percentageArr.count; i++) {
        float percentage = [self.percentageArr[i] floatValue];
        totalSumPercentage = totalSumPercentage+percentage;
        UIBezierPath  *path = [UIBezierPath bezierPath];
        [path moveToPoint:centerPoint];
        if (i==0) {
            lastPercentage=0;
            [path addArcWithCenter:centerPoint radius:radius startAngle:M_PI*2*lastSumPercentage endAngle:M_PI*2*percentage clockwise:YES];
            [self.halfAngleArr addObject:[NSNumber numberWithFloat:M_PI*2*percentage/2.0]];
        }
        else{
            lastPercentage = [self.percentageArr[i-1] floatValue];
            lastSumPercentage = lastSumPercentage + lastPercentage;
            [path addArcWithCenter:centerPoint  radius:radius startAngle:M_PI*2*lastSumPercentage endAngle:M_PI*2*totalSumPercentage clockwise:YES];
            [self.halfAngleArr addObject:[NSNumber numberWithFloat:lastSumPercentage*M_PI*2+(M_PI*2*percentage)/2]];
        }
        [path closePath];
        [self.pathsArr addObject:path];
        
    }
}
-(void)locationTheNoticeLab{
    CGFloat   radius = self.radius;
    CGPoint   centerPoint =CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    CGFloat   offSetRidus = 10;
    CGFloat   offSetX = 10;
    CGFloat   labWidth = 60;
    CGFloat   labHeight= 15;
    for (int i =0; i<self.percentageArr.count; i++) {
        NSNumber   *number = self.halfAngleArr[i];
        float    angle = [number floatValue];
        NSLog(@"----%f",angle);
        CAShapeLayer  *layer = [CAShapeLayer layer];
        layer.lineWidth =1;
        layer.strokeColor =[(UIColor *) self.colorsArr[i] CGColor];
        layer.lineJoin = kCALineJoinRound;
        layer.lineCap = kCALineCapRound;
        layer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        
        UIBezierPath  *linePath = [UIBezierPath bezierPath];
        UILabel  *titleLab = [[UILabel alloc]init];
        titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
        titleLab.text = [NSString stringWithFormat:@"%@%.1f%%",self.titlesArr[i],[self.percentageArr[i] floatValue]*100];
        titleLab.textColor =self.colorsArr[i];
        [self addSubview:titleLab];
        
        [self.polyLineLayerArr addObject:layer];//将折线layer添加到折线数组中
        [self.titleLabArr addObject:titleLab];//将标题lab添加到标题数组中
        
        //注意此处的象限判断与数学上的现象判断不太一样，此处是根据上面的顺时针画圆的方向判断的。
        if (angle>=0&&angle<M_PI_2) {
            //第四象限
            NSLog(@"第4象限");
            CGPoint   startPoint = CGPointMake(radius*cos(angle)+centerPoint.x, centerPoint.y+radius*sin(angle));
            CGPoint  nextPoint = CGPointMake(offSetRidus*cos(M_PI_4)+startPoint.x,startPoint.y+offSetRidus*sin(M_PI_4));
            CGPoint  endPoint = CGPointMake(nextPoint.x+offSetX, nextPoint.y);
            [linePath moveToPoint:startPoint];
            [linePath addLineToPoint:nextPoint];
            [linePath addLineToPoint:endPoint];
            layer.path = linePath.CGPath;
            titleLab.frame = CGRectMake(endPoint.x, endPoint.y-labHeight/2, labWidth, labHeight);
            titleLab.textAlignment = NSTextAlignmentLeft;
        }
        else if (angle>=M_PI_2&&angle<M_PI){
            //第三象限
            NSLog(@"第3象限");
            CGPoint   startPoint = CGPointMake(radius*cos(angle)+centerPoint.x, centerPoint.y+radius*sin(angle));
            CGPoint  nextPoint = CGPointMake(-offSetRidus*cos(M_PI_4)+startPoint.x,startPoint.y+offSetRidus*sin(M_PI_4));
            CGPoint  endPoint = CGPointMake(nextPoint.x-offSetX, nextPoint.y);
            [linePath moveToPoint:startPoint];
            [linePath addLineToPoint:nextPoint];
            [linePath addLineToPoint:endPoint];
            layer.path = linePath.CGPath;
            titleLab.frame = CGRectMake(endPoint.x-labWidth, endPoint.y-labHeight/2, labWidth, labHeight);
            titleLab.textAlignment = NSTextAlignmentRight;
           
            
        }
        else if (angle>=M_PI&&angle<M_PI_2*3){
            //第二象限
            CGPoint   startPoint = CGPointMake(radius*cos(angle)+centerPoint.x, centerPoint.y+radius*sin(angle));
            CGPoint  nextPoint = CGPointMake(-offSetRidus*cos(M_PI_4)+startPoint.x,startPoint.y-offSetRidus*sin(M_PI_4));
            CGPoint  endPoint = CGPointMake(nextPoint.x-offSetX, nextPoint.y);
        
            [linePath moveToPoint:startPoint];
            [linePath addLineToPoint:nextPoint];
            [linePath addLineToPoint:endPoint];
            layer.path = linePath.CGPath;
    
            titleLab.frame = CGRectMake(endPoint.x-labWidth, endPoint.y-labHeight/2, labWidth, labHeight);
            titleLab.textAlignment = NSTextAlignmentRight;
        }
        else{
            //第1象限
            CGPoint   startPoint = CGPointMake(radius*cos(angle)+centerPoint.x, centerPoint.y+radius*sin(angle));
            CGPoint  nextPoint = CGPointMake(offSetRidus*cos(M_PI_4)+startPoint.x,startPoint.y-offSetRidus*sin(M_PI_4));
            CGPoint  endPoint = CGPointMake(nextPoint.x+offSetX, nextPoint.y);
            [linePath moveToPoint:startPoint];
            [linePath addLineToPoint:nextPoint];
            [linePath addLineToPoint:endPoint];
            layer.path = linePath.CGPath;
            titleLab.frame = CGRectMake(endPoint.x, endPoint.y-labHeight/2, labWidth, labHeight);
            titleLab.textAlignment = NSTextAlignmentLeft;
            
        }
    }
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    [self clearSelf];
    [self addShapLayers];
    [self addPaths];
    [self setPathForShapLayer];
    [self locationTheNoticeLab];
    if (!self.layer.mask) {
        self.layer.mask = self.maskLayer;
        [self.maskLayer addAnimation:[self addAnimation] forKey:nil];////
    }
}
-(void)clearSelf{
    for (CAShapeLayer *layer in self.shapLayersArr) {
        [layer removeFromSuperlayer];
    }
    for (CAShapeLayer *layer in self.polyLineLayerArr) {
        [layer removeFromSuperlayer];
    }
    for (UILabel *lab in self.titleLabArr) {
        [lab removeFromSuperview];
    }
    [self.shapLayersArr removeAllObjects];
    [self.polyLineLayerArr removeAllObjects];
    [self.titleLabArr removeAllObjects];
}
//动画
-(CABasicAnimation *)addAnimation{
    CABasicAnimation  *anmiation = [CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    anmiation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmiation.duration = 2;
    anmiation.fromValue=@(0);
    anmiation.toValue = @(1);
    return anmiation;
}
-(CAShapeLayer *)maskLayer{
    //lineWidth属性要设置为半径的二倍否则会出现空心圆
  CGPoint   centerPoint =CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.lineWidth = self.bounds.size.width;
        _maskLayer.strokeColor = [UIColor orangeColor].CGColor;
        _maskLayer.lineCap = kCALineCapButt;
        UIBezierPath  *path = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:self.bounds.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        _maskLayer.path = path.CGPath;
    }
    return _maskLayer;
}
@end
