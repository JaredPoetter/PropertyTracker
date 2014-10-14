//
//  TenantDetailViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/13/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "TenantDetailViewController.h"

@implementation TenantDetailViewController

- (void)viewDidLoad {
    //Setting the labels
    //Name Label
    self.nameLabel.text = [NSString stringWithFormat:@"%@, %@", self.person.lastName, self.person.firstName];
    
    //Cell Phone Label
    self.cellPhoneNumberLabel.text = self.person.cellPhoneNumber;
    
    //House Phone Label
    self.housePhoneNumberLabel.text = self.person.housePhoneNumber;
    
    //Work Phone Label
    self.workPhoneNumberLabel.text = self.person.workPhoneNumber;
    
    //Email Label
    self.emailLabel.text = self.person.email;
    
    //Employer Label
    self.employerLabel.text = self.person.employer;
}

@end