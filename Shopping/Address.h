//
//  Address.h
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Order, User;

@interface Address : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSSet *order;
@property (nonatomic, retain) User *user;
@end

@interface Address (CoreDataGeneratedAccessors)

- (void)addOrderObject:(Order *)value;
- (void)removeOrderObject:(Order *)value;
- (void)addOrder:(NSSet *)values;
- (void)removeOrder:(NSSet *)values;

@end
