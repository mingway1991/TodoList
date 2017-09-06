//
//  FinishedTodoList.m
//  TodoList
//
//  Created by 石茗伟 on 2017/9/6.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "FinishedTodoList.h"
#import "DataBaseManager.h"
#import "NSDate+Util.h"

@interface FinishedTodoList ()

@property (strong) IBOutlet NSTableView *todosTableView;
@property (retain) NSArray<Todo *> *todos;

@end

@implementation FinishedTodoList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.todosTableView setDoubleAction:@selector(tableViewDoubleClick:)];
    [self refreshTable];
}

- (void)refreshTable {
    self.todos = [[DataBaseManager shared] queryFinishedTodos];
    [self.todosTableView reloadData];
}

#pragma mark-
#pragma mark TableView
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.todos.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *strIdt=[tableColumn identifier];
    Todo* todo = [self.todos objectAtIndex:row];
    if([strIdt isEqualToString:@"level"]) {
        NSTableCellView *aView = [tableView makeViewWithIdentifier:strIdt owner:self];
        aView.textField.stringValue = [NSString stringWithFormat:@"%@",@(todo.level)];
        return aView;
    } else if([strIdt isEqualToString:@"content"]) {
        NSTableCellView *aView = [tableView makeViewWithIdentifier:strIdt owner:self];
        aView.textField.stringValue = todo.content;
        return aView;
    } else if([strIdt isEqualToString:@"timestamp"]) {
        NSTableCellView *aView = [tableView makeViewWithIdentifier:strIdt owner:self];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:todo.timestamp];
        aView.textField.stringValue = [NSString stringWithFormat:@"%@",[NSDate yyyyMMddHHmmssWithDate:date]];
        return aView;
    }
    return nil;
}

- (void)tableViewDoubleClick:(id)nid {
    [self performSegueWithIdentifier:@"detail" sender:nil];
}

@end
