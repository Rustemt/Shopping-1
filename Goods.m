//
//  Goods.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "Goods.h"
#import "ImageToDataTransformer.h"

@implementation Goods

@dynamic image;
@dynamic name;
@dynamic price;
@dynamic shopCar;
+ (void)initialize {
	if (self == [Goods class]) {
		ImageToDataTransformer *transformer = [[[ImageToDataTransformer alloc] init]autorelease];
		[ImageToDataTransformer setValueTransformer:transformer forName:@"ImageToDataTransformer"];
	}
}

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
