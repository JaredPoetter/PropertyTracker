//
//  Property.h
//  PropertyTracker
//
//  Created by Jared Poetter on 10/9/14.
//  Copyright (c) 2014 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Property : NSManagedObject

@property (nonatomic, retain) NSNumber * baths;
@property (nonatomic, retain) NSNumber * bedrooms;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * houseNumber;
@property (nonatomic, retain) NSNumber * rent;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * streetName;
@property (nonatomic, retain) NSNumber * zipCode;
@property (nonatomic, retain) NSSet *picture;
@property (nonatomic, retain) NSSet *rentEvent;
@end

@interface Property (CoreDataGeneratedAccessors)

- (void)addPictureObject:(NSManagedObject *)value;
- (void)removePictureObject:(NSManagedObject *)value;
- (void)addPicture:(NSSet *)values;
- (void)removePicture:(NSSet *)values;

- (void)addRentEventObject:(NSManagedObject *)value;
- (void)removeRentEventObject:(NSManagedObject *)value;
- (void)addRentEvent:(NSSet *)values;
- (void)removeRentEvent:(NSSet *)values;

@end
