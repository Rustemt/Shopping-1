//
//  CoreDataManager.h
//  CoreData
//
//  Created by Mingle Chang on 13-10-17.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject
//数据模型对象
@property(nonatomic,retain)NSManagedObjectModel *managedObjectModel;
//上下文对象
@property(nonatomic,retain)NSManagedObjectContext *managedObjectContext;
//持久性存储区
@property(nonatomic,retain)NSPersistentStoreCoordinator *persistenStoreCoordinator;
//初始化CoreData使用的数据库
-(NSPersistentStoreCoordinator *)persistenStoreCoordinator;
//managedObjectModel的初始化赋值函数
-(NSManagedObjectModel *)managedObjectModel;
//managedObjectContext的初始化赋值函数
-(NSManagedObjectContext *)managedObjectContext;

+(CoreDataManager *)shareManager;
-(NSArray *)allStudents;
@end
