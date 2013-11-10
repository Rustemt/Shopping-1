//
//  OrderViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-8.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "OrderViewController.h"
#import "User.h"
#import "ShopCar.h"
#import "Goods.h"
#import "Order.h"
#import "Address.h"
@interface OrderViewController ()

@end

@implementation OrderViewController

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
    UIBarButtonItem *lRightBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarButtonClick:)];
    self.navigationItem.rightBarButtonItem=lRightBarButton;
    [lRightBarButton release];
    
    UITableView *lTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 150) style:UITableViewStylePlain];
    lTableView.delegate=self;
    lTableView.dataSource=self;
    [self.view addSubview:lTableView];
    
    UILabel *lNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 170, 100, 30)];
    lNameLabel.text=_address.name;
    [self.view addSubview:lNameLabel];
    [lNameLabel release];
    
    UILabel *lTelephoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 220, 200, 30)];
    lTelephoneLabel.text=_address.telephone;
    [self.view addSubview:lTelephoneLabel];
    [lTelephoneLabel release];
    
    UILabel *lAddressLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 270, 250, 80)];
    lAddressLabel.numberOfLines=2;
    lAddressLabel.text=_address.address;
    [self.view addSubview:lAddressLabel];
    [lAddressLabel release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_address release];
    [super dealloc];
}
-(void)rightBarButtonClick:(UIBarButtonItem *)sender{//创建一个订单
    Order *lOrder=(Order *)[NSEntityDescription insertNewObjectForEntityForName:@"Order" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];//创建一个订单
    Address *lAddress=(Address *)[NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];//创建一个地址，该地址的信息与用户所选的信息一样，但内存地址不一样，不是同一个地址
    lAddress.name=_address.name;
    lAddress.telephone=_address.telephone;
    lAddress.address=_address.address;
    lOrder.address=lAddress;
    lOrder.date=[NSDate date];
    //用于订单号生成
    NSInteger value=[[NSUserDefaults standardUserDefaults]integerForKey:@"orderNumber"];
    value=value+1;
    lOrder.number=[NSString stringWithFormat:@"%09i",value];
    [[NSUserDefaults standardUserDefaults]setInteger:value forKey:@"orderNumber"];
    [NSUserDefaults standardUserDefaults];
    
    lOrder.state=[NSNumber numberWithBool:NO];
    [lOrder addShopCar:[ShoppingManager shareManager].user.shopCar];
    [[ShoppingManager shareManager].user removeShopCar:[ShoppingManager shareManager].user.shopCar];
    [[ShoppingManager shareManager].user addOrderObject:lOrder];
    NSError *error;
    if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
        NSLog(@"Save Success");
    }else{
        NSLog(@"%@,%@",error,[error userInfo]);
    }
    UIViewController *lViewController=[[self.navigationController viewControllers]objectAtIndex:1];
    [self.navigationController popToViewController:lViewController animated:YES];
}
-(double)allPrice{
    double totalPrice=0.0;
    for (ShopCar *lShopCar in [ShoppingManager shareManager].user.shopCar) {
        int count=[lShopCar.number intValue];
        double price=[lShopCar.goods.price doubleValue];
        totalPrice+=count*price;
    }
    return totalPrice;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
@end
