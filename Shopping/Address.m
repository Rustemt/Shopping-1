//
//  Address.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "Address.h"
#import "Order.h"
#import "User.h"


@implementation Address

@dynamic address;
@dynamic name;
@dynamic telephone;
@dynamic order;
@dynamic user;
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
    NSMutableSet *lMutableSet=[NSMutableSet setWithSet:self.order];
    [lMutableSet minusSet:values];
    self.order=[NSSet setWithSet:lMutableSet];
}
@end
