//
//  FirstViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FilterPropertyViewController.h"
//#import "Property.h"

@interface PropertyViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FilterPropertyViewControllerDelegate>

//@property (strong, nonatomic) Property * property;

//@property (strong, nonatomic) id delegate;

@end

