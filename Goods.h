//
//  Goods.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ShopCar;
@interface Goods : NSManagedObject

@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSSet *shopCar;
@end

@interface Goods (CoreDataGeneratedAccessors)

- (void)addShopCarObject:(ShopCar *)value;
- (void)removeShopCarObject:(ShopCar *)value;
- (void)addShopCar:(NSSet *)values;
- (void)removeShopCar:(NSSet *)values;

@end
