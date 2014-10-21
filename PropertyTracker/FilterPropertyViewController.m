//
//  FilterPropertyViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/20/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "FilterPropertyViewController.h"

@implementation FilterPropertyViewController

- (void)viewDidLoad {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //Passing back the filter for the properties to display
    if([self.delegate respondsToSelector:@selector(filterPropertyViewControllerDismissed:)])
    {
        [self.delegate filterPropertyViewControllerDismissed:@"THIS IS THE STRING TO SEND!!!"];
    }
}

#pragma mark Buttons

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearFilter:(id)sender {

}

- (IBAction)applyFilter:(id)sender {

}

@end
