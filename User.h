//
//  User.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Address, Order, ShopCar;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSSet *shopCar;
@property (nonatomic, retain) NSSet *address;
@property (nonatomic, retain) NSSet *order;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addShopCarObject:(ShopCar *)value;
- (void)removeShopCarObject:(ShopCar *)value;
- (void)addShopCar:(NSSet *)values;
- (void)removeShopCar:(NSSet *)values;

- (void)addAddressObject:(Address *)value;
- (void)removeAddressObject:(Address *)value;
- (void)addAddress:(NSSet *)values;
- (void)removeAddress:(NSSet *)values;

- (void)addOrderObject:(Order *)value;
- (void)removeOrderObject:(Order *)value;
- (void)addOrder:(NSSet *)values;
- (void)removeOrder:(NSSet *)values;

@end
