//
//  AdminViewController.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "AdminViewController.h"
#import "Goods.h"
#import "AddGoodsViewController.h"
@interface AdminViewController ()

@end

@implementation AdminViewController

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
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    [rightBarButton release];
    
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_tableView reloadData];
}
-(void)dealloc{
    [_tableView release];
    [super dealloc];
}
#pragma mark - Private Method
-(void)rightBarButtonItemClick:(UIBarButtonItem *)sender{//进入商品添加界面
    NSLog(@"Right Bar Button Click");
    AddGoodsViewController *lAddGoodsViewController=[[AddGoodsViewController alloc]init];
    [self.navigationController pushViewController:lAddGoodsViewController animated:YES];
    [lAddGoodsViewController release];
}
#pragma mark - TableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{//根据商品数量决定需要返回多少行cell
    return [[ShoppingManager shareManager]allGoods].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//仅仅是为了显示商品
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:lCellID]autorelease];
        lCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSInteger row=[indexPath row];
    NSArray *lArray=[[ShoppingManager shareManager] allGoods];
    Goods *lGoods=[lArray objectAtIndex:row];
    lCell.imageView.image=lGoods.image;
    lCell.textLabel.text=lGoods.name;
    lCell.detailTextLabel.text=[NSString stringWithFormat:@"$%0.2f",[lGoods.price doubleValue]];
    return lCell;
}
@end
