//
//  AddPropertyViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/10/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "AddPropertyViewController.h"
#import "AppDelegate.h"

@implementation AddPropertyViewController

- (void) viewDidLoad {
    //Setting all of the UITextField's Delegate
    self.propertyCity.delegate = self;
    self.propertyHouseNumber.delegate = self;
    self.propertyStreetName.delegate = self;
    
    //    [self.view setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(singleTapAction:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

#pragma mark Gestures

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
    NSLog(@"dslkjflk");
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newProperty;
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue: self.propertyStreetName.text forKey:@"streetName"];
    [newProperty setValue: self.propertyCity.text forKey:@"city"];
//    [newProperty setValue: self.propertyHouseNumber.text forKey:@"houseNumber"];
    
//    [self.propertyStreetNames addObject:@"Hwy 13"];
    //    [newContact setValue: @"(555) 555 - 5555" forKey:@"phone"];
    //    [self.phone addObject:@"(555) 555 - 5555"];
    NSError *error;
    [context save:&error];
//    [self.propertyTableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
