//
//  Payment.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Payment : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * month;
@property (nonatomic, retain) NSString * paymentType;
@property (nonatomic, retain) NSManagedObject *renter;
@property (nonatomic, retain) NSManagedObject *rentEvent;

@end
