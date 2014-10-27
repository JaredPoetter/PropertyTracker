//
//  FilterTenantViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/24/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "FilterTenantViewController.h"

@implementation FilterTenantViewController

- (void)viewDidLoad {
    //Checking to see if the filterArray is initialized
    if (self.filterArray == nil) {
        NSLog(@"creating the filter array");
        self.filterArray = [[NSMutableArray alloc] init];
    }
    else{
        NSLog(@"filling in the text fields");
        self.filterFirstName.text = self.filterArray[FIRST_NAME_INDEX];
        self.filterLastName.text = self.filterArray[LAST_NAME_INDEX];
        self.filterCellPhone.text = self.filterArray[CELL_PHONE_INDEX];
        self.filterHousePhone.text = self.filterArray[HOUSE_PHONE_INDEX];
        self.filterWorkPhone.text  = self.filterArray[WORK_PHONE_INDEX];
        self.filterEmail.text = self.filterArray[EMAIL_INDEX];
        self.filterEmployer.text = self.filterArray[EMPLOYER_INDEX];
    }
    
    //Tap gesture so that when the keyboard is up the user is able to dismiss it with a tap any where
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(singleTapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated {
    //Passing back the filter for the properties to display
    if([self.delegate respondsToSelector:@selector(filterTenantViewControllerDismissed:)])
    {
        //Checking which button was pressed
        if (self.filterButton == CANCEL_FILTER_BUTTON) {
            
        }
        else if (self.filterButton == CLEAR_FILTER_BUTTON) {
            [self.delegate filterTenantViewControllerDismissed:nil];
        }
        else if(self.filterButton == APPLY_FILTER_BUTTON) {
            
            [self.filterArray insertObject:self.filterFirstName.text atIndex:FIRST_NAME_INDEX];
            [self.filterArray insertObject:self.filterLastName.text atIndex:LAST_NAME_INDEX];
            [self.filterArray insertObject:self.filterCellPhone.text atIndex:CELL_PHONE_INDEX];
            [self.filterArray insertObject:self.filterHousePhone.text atIndex:HOUSE_PHONE_INDEX];
            [self.filterArray insertObject:self.filterWorkPhone.text atIndex:WORK_PHONE_INDEX];
            [self.filterArray insertObject:self.filterEmail.text atIndex:EMAIL_INDEX];
            [self.filterArray insertObject:self.filterEmployer.text atIndex:EMPLOYER_INDEX];
            
            [self.delegate filterTenantViewControllerDismissed:self.filterArray];
        }
    }
}

#pragma mark Gestures

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark Buttons

- (IBAction)cancel:(id)sender {
    //Dismissing the filter view
    self.filterButton = CANCEL_FILTER_BUTTON;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearFilter:(id)sender {
    self.filterButton = CLEAR_FILTER_BUTTON;
    
    //Clearing the filter
    self.filterFirstName.text = nil;
    self.filterLastName.text = nil;
    self.filterCellPhone.text = nil;
    self.filterHousePhone.text = nil;
    self.filterWorkPhone.text = nil;
    self.filterEmail.text = nil;
    self.filterEmployer.text = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)applyFilter:(id)sender {
    self.filterButton = APPLY_FILTER_BUTTON;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
