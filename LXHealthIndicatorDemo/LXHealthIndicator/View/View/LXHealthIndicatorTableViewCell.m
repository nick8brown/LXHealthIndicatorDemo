//
//  LXHealthIndicatorTableViewCell.m
//  FreelyHeath
//
//  Created by LX Zeng on 2018/10/17.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "LXHealthIndicatorTableViewCell.h"
#import "LXHealthIndicatorItem.h"

@interface LXHealthIndicatorTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LXHealthIndicatorTableViewCell

#pragma mark - private func
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    return [[[self class] alloc] initWithTableView:tableView];
}

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
        self = DequeueReusable_Cell;
    }
    return self;
}

#pragma mark - setter&getter
- (void)setItem:(LXHealthIndicatorItem *)item {
    _item = item;

    if (item) {
        //
        NSString *icon = @[@"index_stature", @"index_weight", @"index_bloodpressure", @"index_bloodsugar", @"index_abdominalgirth", @"index_fat", @"index_BMI"][[item.code integerValue]-1];
        self.iconImgView.image = ImageNamed(icon);
        
        //
        self.nameLabel.text = item.name;
        
        //
        self.valueLabel.text = [NSString stringWithFormat:@"%@%@%@", item.timesection, item.num, item.unit];

        //
        if (item.createtime.length) {
            NSString *createtime = [NSString substring:item.createtime WithRange:NSMakeRange(5, 11)];
            self.timeLabel.text = createtime;
        }
    }
}

#pragma mark - 添加健康指标
- (IBAction)addHealthIndicatorBtnClick:(UIButton *)sender {
    NSLog(@"-----【我的】-----【健康指标】-----【添加健康指标】-----");
    
    if (self.addHealthIndicatorBtnBlock) {
        self.addHealthIndicatorBtnBlock(self.item.code);
    }
}

@end
