//
//  User.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "User.h"
#import "Address.h"
#import "Order.h"
#import "ShopCar.h"


@implementation User

@dynamic name;
@dynamic password;
@dynamic sex;
@dynamic shopCar;
@dynamic address;
@dynamic order;
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

- (void)addAddressObject:(Address *)value{
    if (self.address==nil) {
        self.address=[NSSet setWithObject:value];
    }else{
        self.address=[self.address setByAddingObject:value];
    }
}
- (void)removeAddressObject:(Address *)value{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.address];
    [lMutableSet removeObject:value];
    self.address=[NSSet setWithSet:lMutableSet];
}
- (void)addAddress:(NSSet *)values{
    if (self.address==nil) {
        self.address=[NSSet setWithSet:values];
    }else{
        self.address=[self.address setByAddingObjectsFromSet:values];
    }
}
- (void)removeAddress:(NSSet *)values{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.address];
    [lMutableSet minusSet:values];
    self.address=[NSSet setWithSet:lMutableSet];
}

- (void)addOrderObject:(Order *)value{
    if (self.order==nil) {
        self.order=[NSSet setWithObject:value];
    }else{
        self.order=[self.order setByAddingObject:value];
    }
}
- (void)removeOrderObject:(Order *)value{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.order];
    [lMutableSet removeObject:value];
    self.order=[NSSet setWithSet:lMutableSet];
}
- (void)addOrder:(NSSet *)values{
    if (self.order==nil) {
        self.order=[NSSet setWithSet:values];
    }else{
        self.order=[self.order setByAddingObjectsFromSet:values];
    }
}
- (void)removeOrder:(NSSet *)values{
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.address];
    [lMutableSet minusSet:values];
    self.address=[NSSet setWithSet:lMutableSet];
}
@end
