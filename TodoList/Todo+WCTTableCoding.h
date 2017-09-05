//
//  Todo+WCTTableCoding.h
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "Todo.h"
#import <WCDB/WCDB.h>

@interface Todo (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(timestamp)
WCDB_PROPERTY(content)
WCDB_PROPERTY(level)
WCDB_PROPERTY(isFinished)

@end
