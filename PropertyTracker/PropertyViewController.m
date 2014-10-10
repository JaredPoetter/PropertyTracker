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

@interface PropertyViewController ()

@property (weak, nonatomic) IBOutlet UITableView *propertyTableView;

@property (strong, nonatomic) NSMutableArray * propertyStreetNames;

@property (strong, nonatomic) NSArray * properties;

@end

@implementation PropertyViewController {
    NSArray * dummyData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.properties = [[NSArray alloc] init];
    
    self.propertyStreetNames = [[NSMutableArray alloc] init];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(streetName = %@)", @"Hwy 13"];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0)
    {
        NSLog(@"No matches");
    }
    else
    {
        for (int i = 0; i < [objects count]; i++)
        {
            matches = objects[i];
            [self.propertyStreetNames addObject:[matches valueForKey:@"streetName"]];
//            [self.phone addObject:[matches valueForKey:@"phone"]];
        }
    }
    
    
//    dummyData = @[@"cell 1", @"cell 2", @"cell 3", @"cell 4", @"cell 5", @"cell 6"];
    
    
    
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navigation Bar

- (IBAction)addProperty:(id)sender {
    
}

- (IBAction)reload:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
//    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(streetName = %@)", @"Hwy 13"];
//    [request setPredicate:pred];
//    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    self.properties = objects;
    
    [self.propertyTableView reloadData];
}

- (IBAction)deleteDatabase:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate flushDatabase];
    [self.propertyTableView reloadData];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.properties.count;
    
    //    return self.propertyStreetNames.count;
    
    //    return dummyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"PropertyCell_ID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    cell.backgroundColor = [UIColor redColor];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
//    cell.textLabel.text = [dummyData objectAtIndex:indexPath.row];
//    cell.textLabel.text = [self.propertyStreetNames objectAtIndex:indexPath.row];
    Property * property = (Property *) [self.properties objectAtIndex:indexPath.row];
    cell.textLabel.text = property.streetName;
    return cell;
}

@end
