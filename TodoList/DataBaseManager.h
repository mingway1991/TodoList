//
//  DataBaseManager.h
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"
#import "Todo+WCTTableCoding.h"

@interface DataBaseManager : NSObject

+ (DataBaseManager *)shared;
- (void)createTable;
- (BOOL)insertTodo:(Todo *)todo;
- (NSArray<Todo *> *)queryUnfinishedTodos;
- (NSArray<Todo *> *)queryFinishedTodos;
- (BOOL)deleteTodo:(Todo *)todo;
- (BOOL)finishTodo:(Todo *)todo;

@end
