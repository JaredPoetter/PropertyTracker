//
//  PropertyDetailViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/12/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"

@interface PropertyDetailViewController : UIViewController

@property (strong, nonatomic) Property * property;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *bathsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedroomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentLabel;

@end
