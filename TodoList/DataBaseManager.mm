//
//  DataBaseManager.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "DataBaseManager.h"
#import <WCDB/WCDB.h>

static NSString *kTodoTableName = @"todo";

static DataBaseManager *_dbManager;

@interface DataBaseManager ()

@property (nonatomic, strong) WCTDatabase *database;

@end

@implementation DataBaseManager

+ (DataBaseManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbManager = [[DataBaseManager alloc] init];
    });
    return _dbManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createTable];
    }
    return self;
}

- (void)createTable {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *dbPath = [NSString stringWithFormat:@"%@/todo.db",docDir];
    self.database = [[WCTDatabase alloc] initWithPath:dbPath];
    BOOL result = [self.database createTableAndIndexesOfName:kTodoTableName
                                              withClass:Todo.class];
    if (!result) {
        NSLog(@"创建数据库失败");
    }
}

- (BOOL)insertTodo:(Todo *)todo {
    BOOL result = [self.database insertObject:todo
                                         into:kTodoTableName];
    if (result) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
    return result;
}

- (NSArray<Todo *> *)queryUnfinishedTodos {
    NSArray<Todo *> *todos = [self.database getObjectsOfClass:Todo.class
                                                    fromTable:kTodoTableName
                                                        where:Todo.isFinished==NO
                                                      orderBy:Todo.timestamp.order(WCTOrderedDescending)];
    return todos;
}

- (NSArray<Todo *> *)queryFinishedTodos {
    NSArray<Todo *> *todos = [self.database getObjectsOfClass:Todo.class
                                                    fromTable:kTodoTableName
                                                        where:Todo.isFinished==YES
                                                      orderBy:Todo.timestamp.order(WCTOrderedDescending)];
    return todos;
}

- (BOOL)deleteTodo:(Todo *)todo {
    BOOL result = [self.database deleteObjectsFromTable:kTodoTableName
                                                  where:Todo.timestamp==todo.timestamp];
    if (result) {
        NSLog(@"删除数据成功");
    } else {
        NSLog(@"删除数据失败");
    }
    return result;
}

- (BOOL)finishTodo:(Todo *)todo {
    todo.isFinished = YES;
    BOOL result = [self.database updateRowsInTable:kTodoTableName
                                        onProperty:Todo.isFinished
                                         withValue:@(todo.isFinished)
                                             where:Todo.timestamp==todo.timestamp];
    if (result) {
        NSLog(@"修改数据成功");
    } else {
        NSLog(@"修改数据失败");
    }
    return result;
}

@end
