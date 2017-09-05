//
//  TodoListVC.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/2.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "TodoListVC.h"
#import <WCDB/WCDB.h>
#import "DataBaseManager.h"
#import "NSDate+Util.h"
#import "TodoDetailVC.h"

@interface TodoListVC () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTableView *todosTableView;
@property (retain) NSArray<Todo *> *todos;

@end

@implementation TodoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.todosTableView setDoubleAction:@selector(tableViewDoubleClick:)];
    [self refreshTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"reloadTodoList" object:nil];
}

- (void)refreshTable {
    self.todos = [[DataBaseManager shared] queryUnfinishedTodos];
    [self.todosTableView reloadData];
}

#pragma mark -
#pragma mark Segue
- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        NSInteger rowNumber = [self.todosTableView clickedRow];
        Todo* todo = [self.todos objectAtIndex:rowNumber];
        TodoDetailVC *vc = segue.destinationController;
        vc.todo = todo;
    }
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
