//
//  OrderListViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-8.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "OrderListViewController.h"
#import "User.h"
#import "Order.h"
#import "Goods.h"
#import "Address.h"
#import "ShopCar.h"
@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITableView *lTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    lTableView.dataSource=self;
    lTableView.delegate=self;
    [self.view addSubview:lTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(double)allPrice:(NSInteger)section{
    double totalPrice=0.0;
    Order *lOrder=[[[ShoppingManager shareManager].user.order allObjects]objectAtIndex:section];
    for (ShopCar *lShopCar in lOrder.shopCar) {
        int count=[lShopCar.number intValue];
        double price=[lShopCar.goods.price doubleValue];
        totalPrice+=count*price;
    }
    return totalPrice;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{//根据用户订单数量显示有多少组
    return [ShoppingManager shareManager].user.order.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//根据每一个订单中所选商品的数量决定但前组显示多少行
    Order *lOrder=[[[ShoppingManager shareManager].user.order allObjects]objectAtIndex:section];
    return lOrder.shopCar.count+1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{//组头用于显示订单号
    Order *lOrder=[[[ShoppingManager shareManager].user.order allObjects]objectAtIndex:section];
    return lOrder.number;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{//组尾用于显示订单日期
    Order *lOrder=[[[ShoppingManager shareManager].user.order allObjects]objectAtIndex:section];
    NSDateFormatter *lDateFormatter=[[NSDateFormatter alloc]init];
    [lDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [lDateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    NSString *lStr=[lDateFormatter stringFromDate:lOrder.date];
    [lDateFormatter release];
    return lStr;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:lCellID]autorelease];
        lCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSInteger row=[indexPath row];
    NSInteger section=[indexPath section];
    Order *lOrder=[[[ShoppingManager shareManager].user.order allObjects]objectAtIndex:section];
    if (row<lOrder.shopCar.count) {
        ShopCar *lShopCar=[[lOrder.shopCar allObjects]objectAtIndex:row];
        lCell.imageView.image=lShopCar.goods.image;
        lCell.textLabel.text=lShopCar.goods.name;
        lCell.detailTextLabel.text=[lShopCar.number stringValue];
    }else{
        lCell.imageView.image=nil;
        lCell.textLabel.text=@"AllPrice:";
        lCell.detailTextLabel.text=[NSString stringWithFormat:@"$%0.2f",[self allPrice:section]];
    }
    return lCell;
}
@end
