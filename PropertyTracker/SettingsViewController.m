//
//  SettingsViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/12/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@implementation SettingsViewController

- (IBAction)deleteDatabase:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate flushDatabase];
//    [self.propertyTableView reloadData];
}

@end
