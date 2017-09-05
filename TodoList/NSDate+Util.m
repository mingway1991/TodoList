//
//  NSDate+Util.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

+ (NSString *)yyyyMMddHHmmssWithDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

@end
