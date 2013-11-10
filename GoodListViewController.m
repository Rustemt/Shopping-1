//
//  GoodListViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "GoodListViewController.h"
#import "User.h"
#import "Goods.h"
#import "GoodsInfoViewController.h"
#import "ShoppingCarViewController.h"
#import "OrderListViewController.h"
@interface GoodListViewController ()

@end

@implementation GoodListViewController

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
    UILabel *lNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 40)];
    lNameLabel.font=[UIFont boldSystemFontOfSize:30];
    lNameLabel.text=[ShoppingManager shareManager].user.name;
    [self.view addSubview:lNameLabel];
    [lNameLabel release];
    
    UILabel *lSexLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 50, 20)];
    lSexLabel.font=[UIFont italicSystemFontOfSize:12];
    if ([[ShoppingManager shareManager].user.sex boolValue]) {
        lSexLabel.text=@"male";
    }else{
        lSexLabel.text=@"female";
    }
    [self.view addSubview:lSexLabel];
    [lSexLabel release];
    
    _shopCarLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 10, 190, 20)];
    [self.view addSubview:_shopCarLabel];
    
    UIButton *lButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton setFrame:CGRectMake(130, 50, 190, 20)];
    [lButton addTarget:self action:@selector(enterShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    [lButton setTitle:@"Enter ShoppingCar" forState:UIControlStateNormal];
    [self.view addSubview:lButton];
    
    UIButton *lButton1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [lButton1 setFrame:CGRectMake(130, 80, 190, 20)];
    [lButton1 addTarget:self action:@selector(showOrderList:) forControlEvents:UIControlEventTouchUpInside];
    [lButton1 setTitle:@"Show Order" forState:UIControlStateNormal];
    [self.view addSubview:lButton1];
    
    UITableView *lTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-100) style:UITableViewStylePlain];
    lTableView.delegate=self;
    lTableView.dataSource=self;
    [self.view addSubview:lTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //购物车中的所选商品数量显示出来
    if ([ShoppingManager shareManager].user.shopCar==nil||[[ShoppingManager shareManager].user.shopCar count]==0) {
        _shopCarLabel.text=@"ShoppingCar:0";
    }else{
        _shopCarLabel.text=[NSString stringWithFormat:@"ShoppingCar:%i",[[ShoppingManager shareManager].user.shopCar count]];
    }
}
-(void)dealloc{
    [_shopCarLabel release];
    [super dealloc];
}
-(void)enterShoppingCar:(UIButton *)sender{//进入购物车
    ShoppingCarViewController *lViewController=[[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:lViewController animated:YES];
    [lViewController release];
}
-(void)showOrderList:(UIButton *)sender{//进入订单列表
    OrderListViewController *lViewController=[[OrderListViewController alloc]init];
    [self.navigationController pushViewController:lViewController animated:YES];
    [lViewController release];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//根据返回的商品数组决定需要返回多少行cell
    return [[ShoppingManager shareManager]allGoods].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//显示商品信息的cell
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:lCellID]autorelease];
    }
    NSInteger row=[indexPath row];
    NSArray *lArray=[[ShoppingManager shareManager]allGoods];
    Goods *lGoods=[lArray objectAtIndex:row];
    lCell.imageView.image=lGoods.image;
    lCell.textLabel.text=lGoods.name;
    lCell.detailTextLabel.text=[NSString stringWithFormat:@"$%0.2f",[lGoods.price doubleValue]];
    return lCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//进入商品的详细信息
    NSInteger row=[indexPath row];
    NSArray *lArray=[[ShoppingManager shareManager]allGoods];
    Goods *lGoods=[lArray objectAtIndex:row];
    GoodsInfoViewController *lViewController=[[GoodsInfoViewController alloc]init];
    lViewController.goods=lGoods;//在GoodsInfoViewController显示之前将商品传递给它
    [self.navigationController pushViewController:lViewController animated:YES];
    [lViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end