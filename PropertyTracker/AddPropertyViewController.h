//
//  AddPropertyViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/10/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddPropertyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *propertyCity;
@property (weak, nonatomic) IBOutlet UITextField *propertyHouseNumber;
@property (weak, nonatomic) IBOutlet UITextField *propertyStreetName;

@end
