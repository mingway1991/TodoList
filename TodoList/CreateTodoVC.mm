//
//  CreateTodoVC.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "CreateTodoVC.h"
#import "DataBaseManager.h"

@interface CreateTodoVC ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

@implementation CreateTodoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createTodo:(id)sender {
    if (self.textView.string.length > 0) {
        Todo *todo = [[Todo alloc] init];
        todo.content = self.textView.string;
        todo.timestamp = [[NSDate date] timeIntervalSince1970];
        todo.isFinished = NO;
        todo.level = 1;
        BOOL result = [[DataBaseManager shared] insertTodo:todo];
        if (result) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTodoList" object:nil];
            [self dismissViewController:self];
        }
        NSLog(@"%@",self.textView.string);
    } else {
        NSLog(@"请输入todo内容！");
    }
}

@end
