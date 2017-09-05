//
//  Todo.h
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

@interface Todo : NSObject

@property (assign) long long timestamp;      //创建时间戳
@property (retain) NSString *content;          //todo内容
@property (assign) NSInteger level;          //重要等级
@property (assign) BOOL isFinished;          //是否完成

@end
