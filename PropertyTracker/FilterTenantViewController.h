//
//  FilterTenantViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/24/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

//Filter Array Indexes
#define FIRST_NAME_INDEX    0
#define LAST_NAME_INDEX     1
#define CELL_PHONE_INDEX    2
#define HOUSE_PHONE_INDEX   3
#define WORK_PHONE_INDEX    4
#define EMAIL_INDEX         5
#define EMPLOYER_INDEX      6

//Filter Button
#define CANCEL_FILTER_BUTTON    0
#define CLEAR_FILTER_BUTTON     1
#define APPLY_FILTER_BUTTON     2

@protocol FilterTenantViewControllerDelegate <NSObject>

-(void) filterTenantViewControllerDismissed:(NSMutableArray *)array;

@end

@interface FilterTenantViewController : UIViewController

@property (nonatomic, assign) id<FilterTenantViewControllerDelegate> delegate;

//This is the array that contains all the filter text field values
@property (nonatomic, retain) NSMutableArray * filterArray;

//Filter Button
@property int filterButton;

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *filterFirstName;
@property (weak, nonatomic) IBOutlet UITextField *filterLastName;
@property (weak, nonatomic) IBOutlet UITextField *filterCellPhone;
@property (weak, nonatomic) IBOutlet UITextField *filterHousePhone;
@property (weak, nonatomic) IBOutlet UITextField *filterWorkPhone;
@property (weak, nonatomic) IBOutlet UITextField *filterEmail;
@property (weak, nonatomic) IBOutlet UITextField *filterEmployer;

@end
