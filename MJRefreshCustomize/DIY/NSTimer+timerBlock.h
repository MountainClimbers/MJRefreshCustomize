//
//  NSTimer+timerBlock.h
//  JWBizCardNew
//
//  Created by qj.huang on 2018/3/22.
//  Copyright © 2018年 经纬网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (timerBlock)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(void(^)())block
                                    repeats:(BOOL)repeats;
@end
