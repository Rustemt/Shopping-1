//
//  GoodsInfoViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "ShopCar.h"
#import "Goods.h"
#import "User.h"
@interface GoodsInfoViewController ()

@end

@implementation GoodsInfoViewController

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
    UIImageView *lImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    lImageView.image=self.goods.image;
    [self.view addSubview:lImageView];
    [lImageView release];
    
    UILabel *lNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, 160, 40)];
    lNameLabel.font=[UIFont boldSystemFontOfSize:35];
    lNameLabel.text=self.goods.name;
    [self.view addSubview:lNameLabel];
    [lNameLabel release];
    
    UILabel *lPriceLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 50, 60, 20)];
    lPriceLabel.font=[UIFont italicSystemFontOfSize:18];
    lPriceLabel.text=[NSString stringWithFormat:@"$%0.2f",[self.goods.price doubleValue]];
    [self.view addSubview:lPriceLabel];
    [lPriceLabel release];
    
    _countLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 100, 40, 20)];
    _countLabel.text=@"1";
    [_countLabel setTextAlignment:NSTextAlignmentCenter];
    _countLabel.layer.borderColor=[[UIColor blackColor]CGColor];
    _countLabel.layer.borderWidth=1;
    [self.view addSubview:_countLabel];
    
    UIButton *lMinusButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lMinusButton setFrame:CGRectMake(110, 100, 20, 20)];
    lMinusButton.tag=101;
    [lMinusButton addTarget:self action:@selector(countButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [lMinusButton setTitle:@"-" forState:UIControlStateNormal];
    [self.view addSubview:lMinusButton];
    
    UIButton *lPlusButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lPlusButton setFrame:CGRectMake(190, 100, 20, 20)];
    lPlusButton.tag=102;
    [lPlusButton addTarget:self action:@selector(countButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [lPlusButton setTitle:@"+" forState:UIControlStateNormal];
    [self.view addSubview:lPlusButton];
    
    UIButton *lAddToShoppingCarButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lAddToShoppingCarButton setFrame:CGRectMake(70, 150, 180, 50)];
    [lAddToShoppingCarButton addTarget:self action:@selector(addToShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [lAddToShoppingCarButton setTitle:@"Add To ShoppingCar" forState:UIControlStateNormal];
    [self.view addSubview:lAddToShoppingCarButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_countLabel release];
    [super dealloc];
}
-(void)countButtonClick:(UIButton *)sender{//设置需要的商品数量
    int count=[_countLabel.text intValue];
    if (sender.tag==101) {
        count-=1;
    }else{
        count+=1;
    }
    if (count<1) {
        count=1;
    }
    _countLabel.text=[NSString stringWithFormat:@"%i",count];
}
-(void)addToShoppingCar:(UIButton *)sender{//添加购物车
    for (ShopCar *lShopCar in [ShoppingManager shareManager].user.shopCar) {//如果购物车中已经有了该选中的商品，将只是添加该选中商品的数量
        if ([lShopCar.goods isEqual:self.goods]) {
            lShopCar.number=[NSNumber numberWithInt:[lShopCar.number intValue]+[_countLabel.text intValue]];
            NSError *error;
            if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
                NSLog(@"Save Success");
            }else{
                NSLog(@"%@,%@",error,[error userInfo]);
            }
            return;
        }
    }
    //添加新的选中商品入购物车
    ShopCar *lShopCar=(ShopCar *)[NSEntityDescription insertNewObjectForEntityForName:@"ShopCar" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    lShopCar.number=[NSNumber numberWithInt:[_countLabel.text intValue]];
    lShopCar.goods=self.goods;
    [[ShoppingManager shareManager].user addShopCarObject:lShopCar];
    
    NSError *error;
    if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
        NSLog(@"Save Success");
    }else{
        NSLog(@"%@,%@",error,[error userInfo]);
    }
}
@end
