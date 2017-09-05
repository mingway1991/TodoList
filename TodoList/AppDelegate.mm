//
//  AppDelegate.m
//  TodoList
//
//  Created by Mingwei Shi on 2017/9/2.
//  Copyright © 2017年 Mingwei Shi. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBaseManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [DataBaseManager shared];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}


@end
