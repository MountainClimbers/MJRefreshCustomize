//
//  MJDIYSecondHeader.h
//  JWBizCardNew
//
//  Created by qj.huang on 2018/3/27.
//  Copyright © 2018年 经纬网. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface MJDIYSecondHeader : MJRefreshHeader
#pragma mark - 刷新时间相关
/** 利用这个block来决定显示的更新时间文字 */
@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
/** 显示上一次刷新时间的label */
@property (weak, nonatomic) UILabel *timeLabel;

#pragma mark - 状态相关
/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
//* 显示刷新状态的label
//@property (weak, nonatomic) UILabel *refreshStateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

@property (weak, nonatomic) UIImageView *logoImg;

#pragma mark - 是否隐藏时间
@property (nonatomic, assign) BOOL isHiddenTimeLabel;
- (instancetype)initWithFrame:(CGRect)frame isHiddenTimeLabel:(BOOL)isHiddenTimeLabel;

@end
