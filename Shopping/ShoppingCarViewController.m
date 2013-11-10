//
//  ShoppingCarViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "User.h"
#import "ShopCar.h"
#import "Goods.h"
#import "AddressListViewController.h"
@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

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
    UIBarButtonItem *lRightBarButton=[[UIBarButtonItem alloc]initWithTitle:@"Address" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonClick:)];
    self.navigationItem.rightBarButtonItem=lRightBarButton;
    [lRightBarButton release];
    
    UITableView *lTableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    lTableView.delegate=self;
    lTableView.dataSource=self;
    [self.view addSubview:lTableView];
    [lTableView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Method
-(void)rightBarButtonClick:(UIBarButtonItem *)sender{//进入选择收获地址
    AddressListViewController *lViewController=[[AddressListViewController alloc]init];
    [self.navigationController pushViewController:lViewController animated:YES];
    [lViewController release];
}
-(double)allPrice{//计算所有商品的总价
    double totalPrice=0.0;
    for (ShopCar *lShopCar in [ShoppingManager shareManager].user.shopCar) {
        int count=[lShopCar.number intValue];
        double price=[lShopCar.goods.price doubleValue];
        totalPrice+=count*price;
    }
    return totalPrice;
}
#pragma mark - TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//根据用户购物车中所选商品的数量决定行数
    return [ShoppingManager shareManager].user.shopCar.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:lCellID]autorelease];
        lCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSInteger row=[indexPath row];
    if (row<[ShoppingManager shareManager].user.shopCar.count) {
        ShopCar *lShopCar=[[[ShoppingManager shareManager].user.shopCar allObjects]objectAtIndex:row];
        lCell.imageView.image=lShopCar.goods.image;
        lCell.textLabel.text=lShopCar.goods.name;
        lCell.detailTextLabel.text=[lShopCar.number stringValue];
    }else{
        lCell.imageView.image=nil;
        lCell.textLabel.text=@"AllPrice:";
        lCell.detailTextLabel.text=[NSString stringWithFormat:@"$%0.2f",[self allPrice]];
    }
    return lCell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    if (row==[ShoppingManager shareManager].user.shopCar.count) {
        return NO;
    }
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//删除购物中的所选商品
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSInteger row=[indexPath row];
        ShopCar *lShopCar=[[[ShoppingManager shareManager].user.shopCar allObjects]objectAtIndex:row];
        [[ShoppingManager shareManager].user removeShopCarObject:lShopCar];
        [[CoreDataManager shareManager].managedObjectContext deleteObject:lShopCar];//在从购物车删除后，也需要将该所选商品从managedObjectContext中删除
        NSError *error;
        if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
            NSLog(@"Delete Success");
        }else{
            NSLog(@"%@,%@",error,[error userInfo]);
        }
        [tableView reloadData];
    }
}
@end
