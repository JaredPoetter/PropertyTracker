//
//  TenantDetailViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/13/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface TenantDetailViewController : UIViewController

@property (strong, nonatomic) Person * person;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *housePhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *workPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *employerLabel;

@end
