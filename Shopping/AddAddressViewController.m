//
//  AddAddressViewController.m
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "AddAddressViewController.h"
#import "User.h"
#import "Address.h"
@interface AddAddressViewController ()

@end

@implementation AddAddressViewController

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
    UIBarButtonItem *lBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveBarButtonClick:)];
    self.navigationItem.rightBarButtonItem=lBarButtonItem;
    [lBarButtonItem release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nameText release];
    [_telephoneText release];
    [_addressText release];
    [super dealloc];
}
- (IBAction)textEndExit:(UITextField *)sender {
}
-(void)saveBarButtonClick:(UIBarButtonItem *)sender{//创建一个新的地址
    Address *lAddress=(Address *)[NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    lAddress.name=_nameText.text;
    lAddress.telephone=_telephoneText.text;
    lAddress.address=_addressText.text;
    [[ShoppingManager shareManager].user addAddressObject:lAddress];
    NSError *error;
    if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
        NSLog(@"Save Success");
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:nil message:@"Save Susses" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        [lAlertView release];
    }else{
        NSLog(@"%@,%@",error,[error userInfo]);
    }
}
@end
