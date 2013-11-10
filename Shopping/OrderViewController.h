//
//  OrderViewController.h
//  Shopping
//
//  Created by Mingle Chang on 13-11-8.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Address.h"
@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)Address *address;
@end
