//
//  AddTenantViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/13/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "AddTenantViewController.h"
#import "AppDelegate.h"

//Tenant/Person Object - Keys
#define CELL_PHONE_NUMBER_KEY @"cellPhoneNumber"
#define EMAIL_KEY @"email"
#define EMPLOYER_KEY @"employer"
#define FIRST_NAME_KEY @"firstName"
#define HOUSE_PHONE_NUMBER_KEY @"housePhoneNumber"
#define LAST_NAME_KEY @"lastName"
#define WORK_PHONE_NUMBER @"workPhoneNumber"
#define PAYMENT_KEY @"payment"
#define RENT_EVENT_KEY @"rentEvent"

@implementation AddTenantViewController

- (void)viewDidLoad {
    //Setting all the text field's delegates
    self.tenantCellPhoneNumber.delegate = self;
    self.tenantEmail.delegate = self;
    self.tenantEmployer.delegate = self;
    self.tenantFirstName.delegate = self;
    self.tenantHouseNumber.delegate = self;
    self.tenantLastName.delegate = self;
    self.tenantWorkNumber.delegate = self;
    
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
    NSManagedObject *newPerson;
    newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
    [newPerson setValue:self.tenantCellPhoneNumber.text
                 forKey:CELL_PHONE_NUMBER_KEY];
    [newPerson setValue:self.tenantEmail.text
                 forKey:EMAIL_KEY];
    [newPerson setValue:self.tenantEmployer.text
                 forKey:EMPLOYER_KEY];
    [newPerson setValue:self.tenantFirstName.text
                 forKey:FIRST_NAME_KEY];
    [newPerson setValue:self.tenantHouseNumber.text
                 forKey:HOUSE_PHONE_NUMBER_KEY];
    [newPerson setValue:self.tenantLastName.text
                 forKey:LAST_NAME_KEY];
    [newPerson setValue:self.tenantWorkNumber.text
                 forKey:WORK_PHONE_NUMBER];
    
    NSError *error;
    [context save:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
