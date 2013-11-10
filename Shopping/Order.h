//
//  Order.h
//  Shopping
//
//  Created by TY on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, ShopCar, User;

@interface Order : NSManagedObject

@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) Address *address;
@property (nonatomic, retain) NSSet *shopCar;
@property (nonatomic, retain) User *user;
@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addShopCarObject:(ShopCar *)value;
- (void)removeShopCarObject:(ShopCar *)value;
- (void)addShopCar:(NSSet *)values;
- (void)removeShopCar:(NSSet *)values;

@end
