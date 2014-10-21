//
//  FirstViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "PropertyViewController.h"
#import "AppDelegate.h"
#import "PropertyDetailViewController.h"
#import "FilterPropertyViewController.h"
#import "Property.h"

#define PROPERTY_TABLE_VIEW_CELL_ID @"PropertyCell_ID"

// Property UITableViewCell Tags
#define ADDRESS_LABEL   1
#define RENT_LABEL      2
#define BEDROOMS_LABEL  3
#define BATHS_LABEL     4

@interface PropertyViewController ()

@property (strong, nonatomic) IBOutlet UITableView * propertyTableView;

//@property (strong, nonatomic) NSMutableArray * propertyStreetNames;

@property (strong, nonatomic) NSArray * properties;

@end

@implementation PropertyViewController {
    NSArray * dummyData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Setting up the table view
    self.propertyTableView.allowsMultipleSelectionDuringEditing = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    //Reloading the TableView
    [self reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navigation Bar


#pragma mark UITableView

- (void)reload{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.properties.count;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //Delete Button
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Getting the context
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSManagedObject * deleteObject = [context objectRegisteredForID:[[self.properties objectAtIndex:indexPath.row] objectID]];

        //Deleting the object
        [context deleteObject:deleteObject];
        
        //Saving changes
        NSError *error = nil;
        if ([context save:&error] == NO) {
            NSAssert(NO, @"Save should not fail\n%@", [error localizedDescription]);
            abort();
        }
    }
    
    //Reloading table view
    [self reload];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"didSelectRowAtIndexPath");
//    self.property = [self.properties objectAtIndex:indexPath.row];
//    [self performSegueWithIdentifier:@"PropertyDetailView_ID" sender:self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"prepareForSegue");
    NSIndexPath *indexPath = self.propertyTableView.indexPathForSelectedRow;
    if ([segue.destinationViewController isKindOfClass:[PropertyDetailViewController class]]) {
        PropertyDetailViewController * propertyDetailVC = (PropertyDetailViewController *) segue.destinationViewController;
        propertyDetailVC.property = self.properties[indexPath.row];
    }
    else if([segue.destinationViewController isKindOfClass:[FilterPropertyViewController class]]) {
        FilterPropertyViewController * filterPropertyVC = (FilterPropertyViewController *) segue.destinationViewController;
        filterPropertyVC.delegate = self;
    }
}

#pragma mark Filter Property

-(void) filterPropertyViewControllerDismissed:(NSString *)string {
    NSLog(string);
}

@end
