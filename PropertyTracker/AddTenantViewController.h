//
//  AddTenantViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/13/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTenantViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tenantFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tenantLastName;
@property (weak, nonatomic) IBOutlet UITextField *tenantCellPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tenantHouseNumber;
@property (weak, nonatomic) IBOutlet UITextField *tenantWorkNumber;
@property (weak, nonatomic) IBOutlet UITextField *tenantEmail;
@property (weak, nonatomic) IBOutlet UITextField *tenantEmployer;

@end
