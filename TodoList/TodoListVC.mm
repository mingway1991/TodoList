//
//  TodoListVC.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/2.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "TodoListVC.h"
#import "DataBaseManager.h"
#import "NSDate+Util.h"
#import "TodoDetailVC.h"
#import "MainConstantDefine.h"

@interface TodoListVC () <NSTableViewDataSource, NSTableViewDelegate>

@property (strong) IBOutlet NSSegmentedControl *segmentedControl;
@property (weak) IBOutlet NSTableView *todosTableView;
@property (retain) NSArray<Todo *> *unfinishedTodos;
@property (retain) NSArray<Todo *> *finishedTodos;
@property (assign) TodoType type;

@end

@implementation TodoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = TodoTypeUnfinished;
    [self.todosTableView setDoubleAction:@selector(tableViewDoubleClick:)];
    [self refreshTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTable) name:@"reloadTodoList" object:nil];
}

- (void)refreshTable {
    self.unfinishedTodos = [[DataBaseManager shared] queryUnfinishedTodos];
    self.finishedTodos = [[DataBaseManager shared] queryFinishedTodos];
    [self.todosTableView reloadData];
}

#pragma mark -
#pragma mark Action
- (IBAction)switchSegmentControl:(id)sender {
    if (self.segmentedControl.selectedSegment == 0) {
        self.type = TodoTypeUnfinished;
    } else if (self.segmentedControl.selectedSegment == 1) {
        self.type = TodoTypeFinished;
    }
    [self.todosTableView reloadData];
}

#pragma mark -
#pragma mark Segue
- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        NSInteger rowNumber = [self.todosTableView clickedRow];
        Todo* todo;
        if (self.type == TodoTypeUnfinished) {
            todo = [self.unfinishedTodos objectAtIndex:rowNumber];
        } else if (self.type == TodoTypeFinished) {
            todo = [self.finishedTodos objectAtIndex:rowNumber];
        }
        TodoDetailVC *vc = segue.destinationController;
        vc.todo = todo;
        vc.type = self.type;
    }
}

#pragma mark-
#pragma mark TableView
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (self.type == TodoTypeUnfinished) {
        return self.unfinishedTodos.count;
    } else if (self.type == TodoTypeFinished) {
        return self.finishedTodos.count;
    }
    return 0;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *strIdt=[tableColumn identifier];
    Todo* todo;
    if (self.type == TodoTypeUnfinished) {
        todo = [self.unfinishedTodos objectAtIndex:row];
    } else if (self.type == TodoTypeFinished) {
        todo = [self.finishedTodos objectAtIndex:row];
    }
    if (!todo) {
        return nil;
    }
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
