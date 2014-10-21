//
//  FilterPropertyViewController.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/20/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterPropertyViewControllerDelegate <NSObject>

-(void) filterPropertyViewControllerDismissed:(NSString *)string;

@end

@interface FilterPropertyViewController : UIViewController

@property (nonatomic, assign) id<FilterPropertyViewControllerDelegate> delegate;

@end
