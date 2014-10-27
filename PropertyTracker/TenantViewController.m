//
//  SecondViewController.m
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import "TenantViewController.h"
#import "AppDelegate.h"
#import "TenantDetailViewController.h"
#import "Person.h"
#import "FilterTenantViewController.h"

#define TENANT_TABLE_VIEW_CELL_ID @"TenantCell_ID"

// Property UITableViewCell Tags
#define NAME_LABEL          1
#define CELL_PHONE_LABEL    2
#define HOUSE_PHONE_LABEL   3
#define WORK_PHONE_LABEL    4

@interface TenantViewController ()

@end

@implementation TenantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Setting up the table view
    self.tenantTableView.allowsMultipleSelectionDuringEditing = NO;
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

- (void)reload {
    //Getting the AppDelegate and CoreData stuff
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSMutableString * filterString = [[NSMutableString alloc] init];
    NSMutableArray * filterStringArray = [[NSMutableArray alloc] init];
    
    //Checking to see if the strings are empty
    if (![self.filterArray[FIRST_NAME_INDEX] isEqualToString:@""] && self.filterArray[FIRST_NAME_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(firstName == \"%@\")", self.filterArray[FIRST_NAME_INDEX]]];
    }
    if (![self.filterArray[LAST_NAME_INDEX] isEqualToString:@""] && self.filterArray[LAST_NAME_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(lastName == \"%@\")", self.filterArray[LAST_NAME_INDEX]]];
    }
    if (![self.filterArray[CELL_PHONE_INDEX] isEqualToString:@""] && self.filterArray[CELL_PHONE_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(cellPhoneNumber == \"%@\")", self.filterArray[CELL_PHONE_INDEX]]];
    }
    if (![self.filterArray[HOUSE_PHONE_INDEX] isEqualToString:@""] && self.filterArray[HOUSE_PHONE_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(housePhoneNumber == \"%@\")", self.filterArray[HOUSE_PHONE_INDEX]]];
    }
    if (![self.filterArray[WORK_PHONE_INDEX] isEqualToString:@""] && self.filterArray[WORK_PHONE_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(workPhoneNumber == \"%@\")", self.filterArray[WORK_PHONE_INDEX]]];
    }
    if (![self.filterArray[EMAIL_INDEX] isEqualToString:@""] && self.filterArray[EMAIL_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(email == \"%@\")", self.filterArray[EMAIL_INDEX]]];
    }
    if (![self.filterArray[EMPLOYER_INDEX] isEqualToString:@""] && self.filterArray[EMPLOYER_INDEX] != nil) {
        [filterStringArray addObject:[NSString stringWithFormat:@"(employer == \"%@\")", self.filterArray[EMPLOYER_INDEX]]];
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
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    self.tenants = objects;
    
    [self.tenantTableView reloadData];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tenants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Checking to see if there is a cell to reuse
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TENANT_TABLE_VIEW_CELL_ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:TENANT_TABLE_VIEW_CELL_ID];
    }
    
    //Property object
    Person * person = (Person *) [self.tenants objectAtIndex:indexPath.row];
    
    //Paid Up or Not
    cell.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:1.0]; //green
    
    //Name Label
    UILabel * nameLabel = (UILabel *) [cell.contentView viewWithTag:NAME_LABEL];
    nameLabel.text = [NSString stringWithFormat:@"%@, %@", person.lastName, person.firstName];
    
    //Cell Phone Number Label
    UILabel * cellPhoneLabel = (UILabel *) [cell.contentView viewWithTag:CELL_PHONE_LABEL];
    cellPhoneLabel.text = person.cellPhoneNumber;
    
    //House Phone Label
    UILabel * housePhoneLabel = (UILabel *) [cell.contentView viewWithTag:HOUSE_PHONE_LABEL];
    housePhoneLabel.text = person.housePhoneNumber;
    
    //Work Phone Label
    UILabel * workPhoneLabel = (UILabel *) [cell.contentView viewWithTag:WORK_PHONE_LABEL];
    workPhoneLabel.text = person.workPhoneNumber;
    
//    //Email Label
//    UILabel * emailLabel = (UILabel *) [cell.contentView viewWithTag:EMAIL_LABEL];
//    emailLabel.text = person.email;
//    
//    //Employer Label
//    UILabel * employerLabel = (UILabel *) [cell.contentView viewWithTag:EMPLOYER_LABEL];
//    employerLabel.text = person.employer;
    
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
        NSManagedObject * deleteObject = [context objectRegisteredForID:[[self.tenants objectAtIndex:indexPath.row] objectID]];
        
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
    NSIndexPath *indexPath = self.tenantTableView.indexPathForSelectedRow;
    if ([segue.destinationViewController isKindOfClass:[TenantDetailViewController class]]) {
        TenantDetailViewController * tenantDetailVC = (TenantDetailViewController *) segue.destinationViewController;
        tenantDetailVC.person = self.tenants[indexPath.row];
    }
    else if([segue.destinationViewController isKindOfClass:[FilterTenantViewController class]]) {
        FilterTenantViewController * filterTenantVC = (FilterTenantViewController *) segue.destinationViewController;
        filterTenantVC.delegate = self;
        filterTenantVC.filterArray = self.filterArray;
    }
}

#pragma mark Filter Property

-(void) filterTenantViewControllerDismissed:(NSMutableArray *)array {
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
