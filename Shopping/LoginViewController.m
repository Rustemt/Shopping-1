//
//  LoginViewController.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "LoginViewController.h"
#import "AdminViewController.h"
#import "RegisterViewController.h"
#import "User.h"
#import "GoodListViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(leftBarButtonItemClick:)];
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBarButtonItemClick:)];
    self.navigationItem.leftBarButtonItem=leftBarButton;
    self.navigationItem.rightBarButtonItem=rightBarButton;
    [leftBarButton release];
    [rightBarButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_nameText release];
    [_passwordText release];
    [super dealloc];
}
#pragma mark - Private Method
-(User *)checkUserInfo{//检查登陆信息是否正确，如果信息正确将该用户所有信息返回，否则返回nil
    NSFetchRequest *lRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *lEntityDecription=[NSEntityDescription entityForName:@"User" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    [lRequest setEntity:lEntityDecription];
    //设置取回请求的谓词
    NSPredicate *lPredicate=[NSPredicate predicateWithFormat:@"name = %@",_nameText.text];
    [lRequest setPredicate:lPredicate];
    
    NSError *error;
    NSArray *lArray=[[CoreDataManager shareManager].managedObjectContext executeFetchRequest:lRequest error:&error];
    [lRequest release];
    if (lArray==nil) {
        return nil;
    }
    if (lArray.count==0) {
        return nil;
    }
    User *lUser=[lArray objectAtIndex:0];
    if ([lUser.password isEqualToString:_passwordText.text]) {
        return lUser;
    }else{
        return nil;
    }
}
-(void)leftBarButtonItemClick:(UIBarButtonItem *)sender{//此处只是为了添加商品
    NSLog(@"Left Bar Button Click");
    AdminViewController *lViewController=[[AdminViewController alloc]init];
    [self.navigationController pushViewController:lViewController animated:YES];
    [lViewController release];
}
-(void)rightBarButtonItemClick:(UIBarButtonItem *)sender{//进入用户注册
    NSLog(@"Right Bar Button Click");
    RegisterViewController *lRegisterViewController=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:lRegisterViewController animated:YES];
    [lRegisterViewController release];
}
- (IBAction)textFieldEndExit:(UITextField *)sender {
}

- (IBAction)registerButtonClick:(UIButton *)sender {//这里还是进入注册
    RegisterViewController *lRegisterViewController=[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:lRegisterViewController animated:YES];
    [lRegisterViewController release];
}

- (IBAction)loginButtonClick:(UIButton *)sender {//登陆按钮点击
    User *lUser=[self checkUserInfo];
    if (lUser) {
        [ShoppingManager shareManager].user=lUser;//将登陆的用户的信息交给单例中的user
        GoodListViewController *lViewController=[[GoodListViewController alloc]init];
        [self.navigationController pushViewController:lViewController animated:YES];
        [lViewController release];
    }else{
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Name or Password is wrong!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        [lAlertView release];
    }
}
@end
