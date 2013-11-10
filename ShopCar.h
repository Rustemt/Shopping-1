//
//  ShopCar.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goods, Order;

@interface ShopCar : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSManagedObject *user;
@property (nonatomic, retain) Goods *goods;
@property (nonatomic, retain) Order *order;

@end
