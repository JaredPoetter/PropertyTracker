//
//  SecondViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FilterTenantViewController.h"

@interface TenantViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FilterTenantViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView * tenantTableView;
@property (strong, nonatomic) NSArray * tenants;

@property (strong, nonatomic) NSMutableArray * filterArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterBarButton;

@end

