//
//  AddressListViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "AddressListViewController.h"
#import "User.h"
#import "Address.h"
#import "AddAddressViewController.h"
#import "OrderViewController.h"
@interface AddressListViewController ()

@end

@implementation AddressListViewController

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
    
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemClick:)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    [rightBarButton release];
    // Do any additional setup after loading the view from its nib.
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
-(void)rightBarButtonItemClick:(UIBarButtonItem *)sender{
    NSLog(@"Right Bar Button Click");
    AddAddressViewController *lAddAddressViewController=[[AddAddressViewController alloc]init];
    [self.navigationController pushViewController:lAddAddressViewController animated:YES];
    [lAddAddressViewController release];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ShoppingManager shareManager].user.address.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *lCellID=@"CellID";
    UITableViewCell *lCell=[tableView dequeueReusableCellWithIdentifier:lCellID];
    if (lCell==nil) {
        lCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:lCellID]autorelease];
    }
    NSInteger row=[indexPath row];
    Address *lAddress=[[[ShoppingManager shareManager].user.address allObjects]objectAtIndex:row];
    lCell.textLabel.text=lAddress.name;
    lCell.detailTextLabel.text=lAddress.address;
    return lCell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSInteger row=[indexPath row];
        Address *lAddress=[[[ShoppingManager shareManager].user.address allObjects]objectAtIndex:row];
        [[ShoppingManager shareManager].user removeAddressObject:lAddress];
        [[CoreDataManager shareManager].managedObjectContext deleteObject:lAddress];
        NSError *error;
        if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
            NSLog(@"Delete Success");
        }else{
            NSLog(@"%@,%@",error,[error userInfo]);
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderViewController *lOrderViewController=[[OrderViewController alloc]init];
    NSInteger row=[indexPath row];
    Address *lAddress=[[[ShoppingManager shareManager].user.address allObjects]objectAtIndex:row];
    lOrderViewController.address=lAddress;
    [self.navigationController pushViewController:lOrderViewController animated:YES];
    [lOrderViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
