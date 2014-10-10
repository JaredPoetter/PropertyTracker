//
//  Person.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Payment, RentEvent;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * cellPhoneNumber;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * employer;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * housePhoneNumber;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * workPhoneNumber;
@property (nonatomic, retain) NSSet *payment;
@property (nonatomic, retain) NSSet *rentEvent;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addPaymentObject:(Payment *)value;
- (void)removePaymentObject:(Payment *)value;
- (void)addPayment:(NSSet *)values;
- (void)removePayment:(NSSet *)values;

- (void)addRentEventObject:(RentEvent *)value;
- (void)removeRentEventObject:(RentEvent *)value;
- (void)addRentEvent:(NSSet *)values;
- (void)removeRentEvent:(NSSet *)values;

@end
