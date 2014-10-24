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
    
    NSMutableString * filterString = [[NSMutableString alloc] init];
    NSMutableArray * filterStringArray = [[NSMutableArray alloc] init];
    
    NSLog(@"house number %@", self.filterArray[HOUSE_NUMBER_INDEX]);
    
    //Checking to see if the strings are empty
    if (![self.filterArray[HOUSE_NUMBER_INDEX] isEqualToString:@""] && self.filterArray[HOUSE_NUMBER_INDEX] != nil) {
//        NSLog(@"house number is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(houseNumber == \"%@\")", self.filterArray[HOUSE_NUMBER_INDEX]]];
    }
    if (![self.filterArray[STREET_NAME_INDEX] isEqualToString:@""] && self.filterArray[STREET_NAME_INDEX] != nil) {
//        NSLog(@"street name is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(streetName == \"%@\")", self.filterArray[STREET_NAME_INDEX]]];
    }
    if (![self.filterArray[CITY_INDEX] isEqualToString:@""] && self.filterArray[CITY_INDEX] != nil) {
//        NSLog(@"city is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(city == \"%@\")", self.filterArray[CITY_INDEX]]];
    }
    if (![self.filterArray[STATE_INDEX] isEqualToString:@""] && self.filterArray[STATE_INDEX] != nil) {
//        NSLog(@"state is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(state == \"%@\")", self.filterArray[STATE_INDEX]]];
    }
    if (![self.filterArray[ZIP_CODE_INDEX] isEqualToString:@""] && self.filterArray[ZIP_CODE_INDEX] != nil) {
//        NSLog(@"zip code is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(zipCode == \"%@\")", self.filterArray[ZIP_CODE_INDEX]]];
    }
    if (![self.filterArray[BATHS_INDEX] isEqualToString:@""] && self.filterArray[BATHS_INDEX] != nil) {
//        NSLog(@"baths is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(baths == \"%@\")", self.filterArray[BATHS_INDEX]]];
    }
    if (![self.filterArray[BEDROOMS_INDEX] isEqualToString:@""] && self.filterArray[BEDROOMS_INDEX] != nil) {
//        NSLog(@"bedrooms is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(bedrooms == \"%@\")", self.filterArray[BEDROOMS_INDEX]]];
    }
    if (![self.filterArray[RENT_INDEX] isEqualToString:@""] && self.filterArray[RENT_INDEX] != nil) {
//        NSLog(@"rent is filled in");
        [filterStringArray addObject:[NSString stringWithFormat:@"(rent == \"%@\")", self.filterArray[RENT_INDEX]]];
    }
    
    NSLog(@"[filterStringArray count] = %lu", (unsigned long)[filterStringArray count]);
    
    NSPredicate *predicate;
    //There is only one condition
    if ([filterStringArray count] == 1) {
        //Creating the predicate
        predicate = [NSPredicate predicateWithFormat:filterStringArray[0]];
        [request setPredicate:predicate];
        
        NSLog(filterStringArray[0]);
    }
    else if ([filterStringArray count] > 1) {
//        NSMutableArray * filterStringArray;
        //Append all the conditions except the last one
        for (int i = 0; i < [filterStringArray count] - 1; i++) {
            NSLog(@"filterStringArray[i] = %@", filterStringArray[i]);
            [filterString appendString:filterStringArray[i]];
            [filterString appendString:@" AND "];
        }
        
        //Append the last one
        [filterString appendString:filterStringArray[[filterStringArray count] - 1]];
        
        //Creating the predicate
        predicate = [NSPredicate predicateWithFormat:filterString];
        [request setPredicate:predicate];
        
        NSLog(filterString);
    }
    
//    NSMutableArray * filterStringArray;
//    for (int i = 0; i < [self.filterArray count]; i++) {
//        //Checking to see if the string is empty
//        if (![self.filterArray[i] isEqualToString:@""]) {
//            [filterString appendString:[NSString stringWithFormat:@"("]];
//        }
//    }
    
    
    
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
        filterPropertyVC.filterArray = self.filterArray;
    }
}

#pragma mark Filter Property

-(void) filterPropertyViewControllerDismissed:(NSMutableArray *)array {
    //Saving the filter array
    self.filterArray = array;
    
    //Checking to see if the filter is applied
    if (array == nil) {
        self.filterBarButton.title = @"Filter";
        self.filterBarButton.tintColor = nil;
    }
    else {
        self.filterBarButton.title = @"FILTERED";
        self.filterBarButton.tintColor = [UIColor blueColor];
    }
}

@end
