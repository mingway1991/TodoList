//
//  TodoDetailVC.h
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DataBaseManager.h"
#import "MainConstantDefine.h"

@interface TodoDetailVC : NSViewController

@property (retain) Todo *todo;
@property (assign) TodoType type;

@end
