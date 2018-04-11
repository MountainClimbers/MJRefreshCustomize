//
//  NSTimer+timerBlock.m
//  JWBizCardNew
//
//  Created by qj.huang on 2018/3/22.
//  Copyright © 2018年 经纬网. All rights reserved.
//

#import "NSTimer+timerBlock.h"

@implementation NSTimer (timerBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(blockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)blockInvoke:(NSTimer *)timer {
    void (^ block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
