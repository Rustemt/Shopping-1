//
//  Order.m
//  Shopping
//
//  Created by TY on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "Order.h"
#import "Address.h"
#import "ShopCar.h"
#import "User.h"


@implementation Order

@dynamic state;
@dynamic date;
@dynamic number;
@dynamic address;
@dynamic shopCar;
@dynamic user;
- (void)addShopCarObject:(ShopCar *)value{
    if (self.shopCar==nil) {
        self.shopCar=[NSSet setWithObject:value];
    }else{
        self.shopCar=[self.shopCar setByAddingObject:value];
    }
}
- (void)removeShopCarObject:(ShopCar *)value{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.shopCar];
    [lMutableSet removeObject:value];
    self.shopCar=[NSSet setWithSet:lMutableSet];
}
- (void)addShopCar:(NSSet *)values{
    if (self.shopCar==nil) {
        self.shopCar=[NSSet setWithSet:values];
    }else{
        self.shopCar=[self.shopCar setByAddingObjectsFromSet:values];
    }
}
- (void)removeShopCar:(NSSet *)values{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.shopCar];
    [lMutableSet minusSet:values];
    self.shopCar=[NSSet setWithSet:lMutableSet];
}
@end
