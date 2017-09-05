//
//  Todo.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "Todo.h"

@implementation Todo

WCDB_IMPLEMENTATION(Todo)
WCDB_SYNTHESIZE(Todo, timestamp)
WCDB_SYNTHESIZE(Todo, content)
WCDB_SYNTHESIZE(Todo, level)
WCDB_SYNTHESIZE(Todo, isFinished)

WCDB_PRIMARY(Todo, timestamp)

WCDB_INDEX(Todo, "_index", timestamp)

@end
