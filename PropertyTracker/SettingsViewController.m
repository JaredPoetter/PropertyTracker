//
//  SettingsViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/12/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

//Property Object - Keys
#define BATHS_KEY           @"baths"
#define BEDROOMS_KEY        @"bedrooms"
#define CITY_KEY            @"city"
#define HOUSE_NUMBER_KEY    @"houseNumber"
#define RENT_KEY            @"rent"
#define STATE_KEY           @"state"
#define STREET_NAME_KEY     @"streetName"
#define ZIP_CODE_KEY        @"zipCode"
#define PICTURE_KEY         @"picture"
#define RENT_EVENT_KEY      @"rentEvent"

@implementation SettingsViewController

- (IBAction)deleteDatabase:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate flushDatabase];
//    [self.propertyTableView reloadData];
}

- (IBAction)populateDatabase:(id)sender {
    //Getting the AppDelegate and other things for Core Data
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error = nil;
    
    //1 Infinite Loop, Cupertino, CA 95014
    //60 E Broadway, Bloomington, MN 55425
    //233 S Wacker Dr, Chicago, IL 60606
    //767 5th Ave, New York, NY 10153
    //350 5th Ave, New York, NY 10118
    
    //Creating a new Property object from CoreData
    NSManagedObject *newProperty;
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:@"Infinite Loop" forKey:STREET_NAME_KEY];
    [newProperty setValue:@"Cupertino" forKey:CITY_KEY];
    [newProperty setValue:@"CA" forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:1] forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:99999] forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInt:95014] forKey:ZIP_CODE_KEY];
    
    //Creating a new Property object from CoreData
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:@"E Broadway" forKey:STREET_NAME_KEY];
    [newProperty setValue:@"Bloomington" forKey:CITY_KEY];
    [newProperty setValue:@"MN" forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:60] forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:99999] forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInt:55425] forKey:ZIP_CODE_KEY];
    
    //Creating a new Property object from CoreData
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:@"S Wacker Dr" forKey:STREET_NAME_KEY];
    [newProperty setValue:@"Chicago" forKey:CITY_KEY];
    [newProperty setValue:@"IL" forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:233] forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:99999] forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInt:60606] forKey:ZIP_CODE_KEY];
    
    //Creating a new Property object from CoreData
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:@"5th Ave" forKey:STREET_NAME_KEY];
    [newProperty setValue:@"New York" forKey:CITY_KEY];
    [newProperty setValue:@"NY" forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:767] forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:99999] forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInt:10153] forKey:ZIP_CODE_KEY];
    
    //Creating a new Property object from CoreData
    newProperty = [NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    [newProperty setValue:@"5th Ave" forKey:STREET_NAME_KEY];
    [newProperty setValue:@"New York" forKey:CITY_KEY];
    [newProperty setValue:@"NY" forKey:STATE_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BATHS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:233] forKey:HOUSE_NUMBER_KEY];
    [newProperty setValue:[NSNumber numberWithInt:100] forKey:BEDROOMS_KEY];
    [newProperty setValue:[NSNumber numberWithInt:99999] forKey:RENT_KEY];
    [newProperty setValue:[NSNumber numberWithInt:10118] forKey:ZIP_CODE_KEY];
    
    //Saving
    error = nil;
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Save should not fail\n%@", [error localizedDescription]);
        abort();
    }
}

@end
