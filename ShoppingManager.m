//
//  ShoppingManager.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "ShoppingManager.h"
static ShoppingManager *shoppingShare=nil;
@implementation ShoppingManager
+(ShoppingManager *)shareManager{
    @synchronized(self){
        if (shoppingShare==nil) {
            shoppingShare=[[ShoppingManager alloc]init];
        }
    }
    return shoppingShare;
}
-(NSArray *)allGoods{
    NSFetchRequest *lRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *lEntityDecription=[NSEntityDescription entityForName:@"Goods" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    [lRequest setEntity:lEntityDecription];
    
    NSError *error;
    NSArray *lArray=[[CoreDataManager shareManager].managedObjectContext executeFetchRequest:lRequest error:&error];
    if (lArray==nil) {
        NSLog(@"%@,%@",error,[error userInfo]);
    }
    [lRequest release];
    return lArray;
}
@end
