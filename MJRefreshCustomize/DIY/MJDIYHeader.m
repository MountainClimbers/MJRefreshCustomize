//
//  MJDIYHeader.m
//  JWBizCardNew
//
//  Created by qj.huang on 2018/3/15.
//  Copyright © 2018年 经纬网. All rights reserved.
//

#import "MJDIYHeader.h"
#import "NSTimer+timerBlock.h"
#import "UIColor+Additional.h"

//宽高定义
#define CircleSelfWidth self.frame.size.width
#define CircleSelfHeight self.frame.size.height
@interface MJDIYHeader()
{
    CGFloat fakeProgress;
    NSTimer *timer;//定时器用作动画
    MJRefreshState refreshState;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@property (nonatomic, copy) NSString *currentText;
@end


@implementation MJDIYHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
//    self.refreshStateLabel.text = self.stateTitles[@(self.state)];
}

-(void)setProgress:(NSString *)progressTitle forState:(MJRefreshState)state {
    if (progressTitle == nil) return;
    
//    self.stateTitles[@(state)] = progressTitle;
//    fakeProgress = [self.stateTitles[@(self.state)] floatValue];

}


//最后一次动画所做的处理
- (void)dealWithLast {
    //最后一次赋准确值
//    fakeProgress = _progress;
    
    fakeProgress = 0;
    [self setNeedsDisplay];
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}


//- (UILabel *)refreshStateLabel
//{
//    if (!_refreshStateLabel) {
//        [self addSubview:_refreshStateLabel = [UILabel mj_label]];
//    }
//    return _refreshStateLabel;
//}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        [self addSubview:_timeLabel = [UILabel mj_label]];
    }
    return _timeLabel;
}

- (UIImageView *)logoImg
{
    if (!_logoImg) {
        
        [self addSubview:_logoImg = [[UIImageView alloc] init]];
    }
    return _logoImg;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        [self prepare];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame totalTime:(CGFloat)time{
    
    if (self = [super initWithFrame:frame]) {
        
        self.totalTime = time;
        
        [self prepare];
    }
    return self;
    
}
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    CGFloat logoImgHeight = 15;
    CGFloat labelHeight = 21;
    
    self.mj_h = 13 + logoImgHeight + 2 * labelHeight + 2 * 5 + 8;

//    if (!_isHiddenPercentage) {
//        self.mj_h = 13 + logoImgHeight + 2 * labelHeight + 2 * 5 + 8;
//
//    } else {
//        self.mj_h = 13 + logoImgHeight + labelHeight + 5 + 8;
//    }
    
    // 添加label2
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor colorFromHexRGB:@"0x666666"];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    // logo
    self.logoImg.image = [UIImage imageNamed:@"icon_sx"];
    self.logoImg.contentMode = UIViewContentModeScaleAspectFit;
    self.logoImg.contentMode = UIViewContentModeCenter;
    
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logoImg.frame = CGRectMake((self.bounds.size.width - 15)*0.5, 13, 15, 15);
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.speed = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99999;
    [self.logoImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.timeLabel.frame = CGRectMake(0, 13 + 15 + 5 + 21, self.bounds.size.width, 21);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = self.lastUpdatedTimeKey;
    
        switch (state) {
            case MJRefreshStateRefreshing:
            {
                fakeProgress = 0;
                //先暂停计时器
                if (timer) {
                    [timer invalidate];
                    timer = nil;
                }
            
                CGFloat defaultIncreaseValue = 0.01009;
                CGFloat cishu = 1 / defaultIncreaseValue;
                __weak typeof(self) weakSelf = self;

                timer = [NSTimer scheduledTimerWithTimeInterval:0.01 block:^{
                        __strong typeof(weakSelf)strongSelf = weakSelf;
                        
                        //正方向动画
                        if (fakeProgress >= 1.0f) {
                            if (fakeProgress >= 1.0f) {
                                fakeProgress = 1.0f;
                            }
                            [strongSelf dealWithLast];
                            if (self.isBaiFengBaiBlock) {
                                self.isBaiFengBaiBlock();
                            }
                            return;
                        } else {
                            //进度条动画
                            if (fakeProgress >= 1.0f) {
                                fakeProgress = 1.0f;
                            }
                            [strongSelf setNeedsDisplay];
                        }
                        //
                        //        //数值增加或减少
                        //        if (_animationModel == CircleIncreaseSameTime) {
                        //            fakeProgress += defaultIncreaseValue*sameTimeIncreaseValue;//不同进度动画时间基本相同
                        //        } else {
                        //            fakeProgress += defaultIncreaseValue;//进度越大动画时间越长。
                        //        }
                        
                        fakeProgress += defaultIncreaseValue;
                        if (fakeProgress >= 1.0f) {
                            fakeProgress = 1.0f;
                        }
                    
                    self.currentText = [NSString stringWithFormat:@"%.2f%%",fakeProgress*100];
//
//                    if(self.totalTime == 0.0){
//                        self.currentText = [NSString stringWithFormat:@"%.2f%%",0.0];
//                    } else {
//                         self.currentText = [NSString stringWithFormat:@"%.2f%%",fakeProgress*100];
//                    }
                    
                    } repeats:YES];
                
                    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
                    
            }
                
                break;
            case MJRefreshStateIdle:
            {
                self.currentText = @"下拉即可同步";
                
                [self setNeedsDisplay];
            }
                break;
            case MJRefreshStatePulling:
            {
                self.currentText = @"下拉即可同步";
                
                //            self.currentText = @"松开立即同步";
                [self setNeedsDisplay];
                
            }
                break;
            default:
                break;
        }
}
  

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
   
}


#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.timeLabel.hidden) return;
    
    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.timeLabel.text = self.lastUpdatedTimeText(lastUpdatedTime);
        return;
    }
    
    if (lastUpdatedTime) {
//        // 1.获得年月日
//        NSCalendar *calendar = [self currentCalendar];
//        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
//        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
//        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        BOOL isToday = NO;
//        if ([cmp1 day] == [cmp2 day]) { // 今天
//            formatter.dateFormat = @" HH:mm";
//            isToday = YES;
//        } else if ([cmp1 year] == [cmp2 year]) { // 今年
//            formatter.dateFormat = @"MM-dd HH:mm";
//        } else {
//            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//        }
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        
        NSArray * timeStrArr= [time componentsSeparatedByString: @"-"];
        NSMutableArray *timeStrMutableArr = [NSMutableArray arrayWithArray:timeStrArr];
        if (timeStrMutableArr.count == 3) {
            timeStrMutableArr[1] = [NSString stringWithFormat:@"%i",[timeStrMutableArr[1] intValue]] ;
            NSArray * time2StrArr= [timeStrMutableArr[2] componentsSeparatedByString: @" "];
            NSMutableArray *time2StrMutableArr = [NSMutableArray arrayWithArray:time2StrArr];
            if (time2StrMutableArr.count == 2) {
                time2StrMutableArr[0] = [NSString stringWithFormat:@"%i",[time2StrMutableArr[0] intValue]] ;
            }
            timeStrMutableArr[2] = [time2StrMutableArr componentsJoinedByString:@" "];
        }
        
        time = [timeStrMutableArr componentsJoinedByString:@"-"];
        
        
        self.timeLabel.text = [NSString stringWithFormat:@"上次同步时间：%@",time];
        
//        // 3.显示日期
//        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@%@",
//                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderLastTimeText],
//                                          isToday ? [NSBundle mj_localizedStringForKey:MJRefreshHeaderDateTodayText] : @"",
//                                          time];
    } else {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *time = [formatter stringFromDate:[NSDate date]];
        self.timeLabel.text = [NSString stringWithFormat:@"上次同步时间：%@",time];


//        self.timeLabel.text = [NSString stringWithFormat:@"最后同步时间：%@",[NSBundle mj_localizedStringForKey:MJRefreshHeaderNoneLastDateText]];
//        self.lastUpdatedTimeLabel.text = [NSString stringWithFormat:@"%@%@",
//                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderLastTimeText],
//                                          [NSBundle mj_localizedStringForKey:MJRefreshHeaderNoneLastDateText]];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    //画文字
    //    self.currentText = [NSString stringWithFormat:@"%.2f%%",fakeProgress*100];
    //段落格式
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    //字体
    UIFont *font = [UIFont systemFontOfSize:13];
    UIColor *color = [UIColor colorFromHexRGB:@"0x3366cc"];
    //构建属性集合
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName:color};
    //获得size
    //    CGSize stringSize = [currentText sizeWithAttributes:attributes];
    //垂直居中
    //    CGRect r = CGRectMake((CircleSelfWidth-stringSize.width)/2.0, (CircleSelfHeight - stringSize.height)/2.0,stringSize.width, stringSize.height);
    
    CGRect r =  CGRectMake(0, CGRectGetMaxY(self.logoImg.frame) + 5, self.bounds.size.width, 21);
    
    [self.currentText drawInRect:r withAttributes:attributes];
 
}

@end
