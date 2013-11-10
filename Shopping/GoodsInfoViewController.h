//
//  GoodsInfoViewController.h
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"
@interface GoodsInfoViewController : UIViewController{
    UILabel *_countLabel;
}
@property(nonatomic,retain)Goods *goods;//用于从商品信息列表获取选中的商品信息
@end
