//
//  FilterPropertyViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/20/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

//Filter Array Indexes
#define HOUSE_NUMBER_INDEX  0
#define STREET_NAME_INDEX   1
#define CITY_INDEX          2
#define STATE_INDEX         3
#define ZIP_CODE_INDEX      4
#define BATHS_INDEX         5
#define BEDROOMS_INDEX      6
#define RENT_INDEX          7

//Filter Button
#define CANCEL_FILTER_BUTTON    0
#define CLEAR_FILTER_BUTTON     1
#define APPLY_FILTER_BUTTON     2

@protocol FilterPropertyViewControllerDelegate <NSObject>

-(void) filterPropertyViewControllerDismissed:(NSMutableArray *)array;

@end

@interface FilterPropertyViewController : UIViewController

@property (nonatomic, assign) id<FilterPropertyViewControllerDelegate> delegate;

//This is the array that contains all the filter text field values
@property (nonatomic, retain) NSMutableArray * filterArray;

//Filter Button
@property int filterButton;

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *filterHouseNumber;
@property (weak, nonatomic) IBOutlet UITextField *filterStreetName;
@property (weak, nonatomic) IBOutlet UITextField *filterCity;
@property (weak, nonatomic) IBOutlet UITextField *filterState;
@property (weak, nonatomic) IBOutlet UITextField *filterZipCode;
@property (weak, nonatomic) IBOutlet UITextField *filterBaths;
@property (weak, nonatomic) IBOutlet UITextField *filterBedrooms;
@property (weak, nonatomic) IBOutlet UITextField *filterRent;

@end
