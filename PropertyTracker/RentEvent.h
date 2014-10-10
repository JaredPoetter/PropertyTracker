//
//  RentEvent.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Payment, Property;

@interface RentEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * deposit;
@property (nonatomic, retain) NSDate * moveInDate;
@property (nonatomic, retain) NSDate * moveOutDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * petDeposit;
@property (nonatomic, retain) NSSet *payment;
@property (nonatomic, retain) Property *property;
@property (nonatomic, retain) NSSet *renter;
@end

@interface RentEvent (CoreDataGeneratedAccessors)

- (void)addPaymentObject:(Payment *)value;
- (void)removePaymentObject:(Payment *)value;
- (void)addPayment:(NSSet *)values;
- (void)removePayment:(NSSet *)values;

- (void)addRenterObject:(NSManagedObject *)value;
- (void)removeRenterObject:(NSManagedObject *)value;
- (void)addRenter:(NSSet *)values;
- (void)removeRenter:(NSSet *)values;

@end
