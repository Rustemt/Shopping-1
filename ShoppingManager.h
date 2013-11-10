//
//  ShoppingManager.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface ShoppingManager : NSObject
@property(nonatomic,retain)User *user;
+(ShoppingManager *)shareManager;
-(NSArray *)allGoods;//返回所有的商品
@end
