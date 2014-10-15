//
//  AddPropertyViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/10/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "AppDelegate.h"

//Property Object - Keys
#define BATHS_KEY @"baths"
#define BEDROOMS_KEY @"bedrooms"
#define CITY_KEY @"city"
#define HOUSE_NUMBER_KEY @"houseNumber"
#define RENT_KEY @"rent"
#define STATE_KEY @"state"
#define STREET_NAME_KEY @"streetName"
#define ZIP_CODE_KEY @"zipCode"
#define PICTURE_KEY @"picture"
#define RENT_EVENT_KEY @"rentEvent"

@implementation AddPropertyViewController

- (void) viewDidLoad {
    //Setting all of the UITextField's Delegate
    self.propertyCity.delegate = self;
    self.propertyHouseNumber.delegate = self;
    self.propertyStreetName.delegate = self;
    self.propertyBaths.delegate = self;
    self.propertyBedrooms.delegate = self;
    self.propertyRent.delegate = self;
    self.propertyZipCode.delegate = self;
    self.propertyState.delegate = self;
        
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(singleTapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

#pragma mark Gestures

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark Keyboard

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType == UIReturnKeyNext) {
        UIView *next = [[textField superview] viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
    } else if (textField.returnKeyType == UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark Buttons

- (IBAction)cancel:(id)sender {
    //TODO: make sure the user wants to cancel
    NSLog(@"User does not want this.");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submit:(id)sender {
    //TODO: make sure all the required fields are filled in
    //TODO: put all the information from the fields into Core Data
    NSLog(@"User wants the data");
    
    //Getting the AppDelegate and other things for Core Data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    //Creating a new Property object from CoreData
    NSManagedObject *newProperty;
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:self.propertyStreetName.text
                   forKey:STREET_NAME_KEY];
    [newProperty setValue:self.propertyCity.text
                   forKey:CITY_KEY];
    [newProperty setValue:self.propertyState.text
                   forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInteger: [self.propertyBaths.text integerValue]]
                   forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInteger: [self.propertyHouseNumber.text integerValue]]
                   forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInteger: [self.propertyBedrooms.text integerValue]]
                   forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInteger: [self.propertyRent.text integerValue]]
                   forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInteger: [self.propertyZipCode.text integerValue]]
                   forKey:ZIP_CODE_KEY];
    
    //Saving
    NSError *error = nil;
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Save should not fail\n%@", [error localizedDescription]);
        abort();
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
