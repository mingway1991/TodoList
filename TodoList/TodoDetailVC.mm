//
//  TodoDetailVC.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/3.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "TodoDetailVC.h"
#import "NSDate+Util.h"

@interface TodoDetailVC ()

@property (unsafe_unretained) IBOutlet NSTextView *contentTextView;
@property (weak) IBOutlet NSTextFieldCell *timestampTextField;

@end

@implementation TodoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTextView.string = self.todo.content;
    self.timestampTextField.stringValue = [NSDate yyyyMMddHHmmssWithDate:[NSDate dateWithTimeIntervalSince1970:self.todo.timestamp]];
}

- (IBAction)deleteTodo:(id)sender {
    [[DataBaseManager shared] deleteTodo:self.todo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTodoList" object:nil];
    [self dismissViewController:self];
}

- (IBAction)finishTodo:(id)sender {
    [[DataBaseManager shared] finishTodo:self.todo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTodoList" object:nil];
    [self dismissViewController:self];
}

@end
