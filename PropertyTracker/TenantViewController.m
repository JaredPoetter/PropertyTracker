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
}

@end
