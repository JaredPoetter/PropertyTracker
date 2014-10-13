//
//  PropertyDetailViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/12/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "PropertyDetailViewController.h"

@implementation PropertyDetailViewController

- (void)viewDidLoad {
    //Setting the labels
    //Address Label
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@, %@ %@",
                              self.property.houseNumber, self.property.streetName,
                              self.property.city, self.property.state, self.property.zipCode];
    
    //Rent Label
    self.rentLabel.text = [NSString stringWithFormat:@"%@", self.property.rent];
    
    //Bedrooms Label
    self.bedroomsLabel.text = [NSString stringWithFormat:@"%@", self.property.bedrooms];
    
    //Baths Label
    self.bathsLabel.text = [NSString stringWithFormat:@"%@", self.property.baths];

}

@end
