//
//  FirstViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "PropertyViewController.h"
#import "AppDelegate.h"
#import "Property.h"

#define PROPERTY_TABLE_VIEW_CELL_ID @"PropertyCell_ID"

// Property UITableViewCell Tags
#define ADDRESS_LABEL   1
#define RENT_LABEL      2
#define BEDROOMS_LABEL  3
#define BATHS_LABEL     4

@interface PropertyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *propertyTableView;

//@property (strong, nonatomic) NSMutableArray * propertyStreetNames;

@property (strong, nonatomic) NSArray * properties;

@end

@implementation PropertyViewController {
    NSArray * dummyData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    //Reloading the TableView
    [self reload:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navigation Bar

- (IBAction)reload:(id)sender {
    //Getting the AppDelegate and CoreData stuff
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    self.properties = objects;
    
    [self.propertyTableView reloadData];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.properties.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Checking to see if there is a cell to reuse
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROPERTY_TABLE_VIEW_CELL_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:PROPERTY_TABLE_VIEW_CELL_ID];
    }
    
    //Property object
    Property * property = (Property *) [self.properties objectAtIndex:indexPath.row];
    
    //Vacancy
    if ([property.rentEvent allObjects].count == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:1.0]; //green
    }
    else {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.9 alpha:1.0]; //red
    }
    
    //Address Label
    UILabel * addressLabel = (UILabel *) [cell.contentView viewWithTag:ADDRESS_LABEL];
    addressLabel.text = [NSString stringWithFormat:@"Address:\n%@ %@\n%@, %@ %@",
                         property.houseNumber, property.streetName,
                         property.city, property.state, property.zipCode];
    
    //Rent Label
    UILabel * rentLabel = (UILabel *) [cell.contentView viewWithTag:RENT_LABEL];
    rentLabel.text = [NSString stringWithFormat:@"Rent: %@", property.rent];
    
    //Bedrooms Label
    UILabel * bedroomsLabel = (UILabel *) [cell.contentView viewWithTag:BEDROOMS_LABEL];
    bedroomsLabel.text = [NSString stringWithFormat:@"Bedrooms: %@", property.bedrooms];
    
    //Baths Label
    UILabel * bathsLabel = (UILabel *) [cell.contentView viewWithTag:BATHS_LABEL];
    bathsLabel.text = [NSString stringWithFormat:@"Baths: %@", property.baths];
    
    return cell;
}

@end
