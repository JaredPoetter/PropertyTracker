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
    //Checking to see if the filterArray is initialized
    if (self.filterArray == nil) {
        NSLog(@"creating the filter array");
        self.filterArray = [[NSMutableArray alloc] init];
    }
    else{
        NSLog(@"filling in the text fields");
        self.filterHouseNumber.text = self.filterArray[HOUSE_NUMBER_INDEX];
        self.filterStreetName.text = self.filterArray[STREET_NAME_INDEX];
        self.filterCity.text = self.filterArray[CITY_INDEX];
        self.filterState.text = self.filterArray[STATE_INDEX];
        self.filterZipCode.text  = self.filterArray[ZIP_CODE_INDEX];
        self.filterBaths.text = self.filterArray[BATHS_INDEX];
        self.filterBedrooms.text = self.filterArray[BEDROOMS_INDEX];
        self.filterRent.text = self.filterArray[RENT_INDEX];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(singleTapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated {
    //Passing back the filter for the properties to display
    if([self.delegate respondsToSelector:@selector(filterPropertyViewControllerDismissed:)])
    {
        //Checking which button was pressed
        if (self.filterButton == CANCEL_FILTER_BUTTON) {
            
        }
        else if (self.filterButton == CLEAR_FILTER_BUTTON) {
            [self.delegate filterPropertyViewControllerDismissed:nil];
        }
        else if(self.filterButton == APPLY_FILTER_BUTTON) {
            
            [self.filterArray insertObject:self.filterHouseNumber.text atIndex:HOUSE_NUMBER_INDEX];
            [self.filterArray insertObject:self.filterStreetName.text atIndex:STREET_NAME_INDEX];
            [self.filterArray insertObject:self.filterCity.text atIndex:CITY_INDEX];
            [self.filterArray insertObject:self.filterState.text atIndex:STATE_INDEX];
            [self.filterArray insertObject:self.filterZipCode.text atIndex:ZIP_CODE_INDEX];
            [self.filterArray insertObject:self.filterBaths.text atIndex:BATHS_INDEX];
            [self.filterArray insertObject:self.filterBedrooms.text atIndex:BEDROOMS_INDEX];
            [self.filterArray insertObject:self.filterRent.text atIndex:RENT_INDEX];
        
            [self.delegate filterPropertyViewControllerDismissed:self.filterArray];
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
    self.filterHouseNumber.text = nil;
    self.filterStreetName.text = nil;
    self.filterCity.text = nil;
    self.filterState.text = nil;
    self.filterZipCode.text = nil;
    self.filterBaths.text = nil;
    self.filterBedrooms.text = nil;
    self.filterRent.text = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)applyFilter:(id)sender {
    self.filterButton = APPLY_FILTER_BUTTON;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
