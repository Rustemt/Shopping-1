//
//  RegisterViewController.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    // Do any additional setup after loading the view from its nib.
    
    UILabel *lNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 70, 90, 30)];
    [lNameLabel setText:@"NAME:"];
    [self.view addSubview:lNameLabel];
    [lNameLabel release];
    
    _nameText=[[UITextField alloc]initWithFrame:CGRectMake(160, 70, 130, 30)];
    [_nameText setBorderStyle:UITextBorderStyleRoundedRect];
    [_nameText addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_nameText];
    
    UILabel *lPassWordLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 120, 90, 30)];
    [lPassWordLabel setText:@"PASSWORD:"];
    [self.view addSubview:lPassWordLabel];
    [lPassWordLabel release];
    
    _passwordText=[[UITextField alloc]initWithFrame:CGRectMake(160, 120, 130, 30)];
    [_passwordText setBorderStyle:UITextBorderStyleRoundedRect];
    [_passwordText addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_passwordText];
    
    UILabel *lSexLabel1=[[UILabel alloc]initWithFrame:CGRectMake(60, 170, 90, 20)];
    [lSexLabel1 setText:@"SEX:"];
    [self.view addSubview:lSexLabel1];
    [lSexLabel1 release];
    
    _sexSegmentedControl=[[UISegmentedControl alloc]initWithItems:@[@"female",@"male"]];
    [_sexSegmentedControl setFrame:CGRectMake(160, 170, 130,30)];
    [_sexSegmentedControl setSelectedSegmentIndex:0];
    [self.view addSubview:_sexSegmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_nameText release];
    [_sexSegmentedControl release];
    [_passwordText release];
    [super dealloc];
}
#pragma mark - Private Method
-(void)textFieldEnd:(UITextField *)sender{
    
}
-(BOOL)checkSameName{//判断是否有同名信息
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
        NSLog(@"%@,%@",error,[error userInfo]);
    }
    if (lArray.count!=0) {
        NSLog(@"The Same Name");
        return YES;
    }
    return NO;
}
-(BOOL)saveUserInfo{//保存用户信息
    User *lUser=(User *)[NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    [lUser setName:_nameText.text];
    [lUser setPassword:_passwordText.text];
    [lUser setSex:[NSNumber numberWithBool:[_sexSegmentedControl selectedSegmentIndex]]];
    
    NSError *error;
    if ([[CoreDataManager shareManager].managedObjectContext save:&error]) {
        NSLog(@"Save Success");
        return YES;
    }else{
        NSLog(@"%@,%@",error,[error userInfo]);
        return NO;
    }
}
-(void)saveBarButtonClick:(UIBarButtonItem *)sender{
    if (_nameText.text==nil||[_nameText.text isEqualToString:@""]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Name Can Not Be Empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        [lAlertView release];
        return;
    }
    if ([self checkSameName]) {
        UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"The Same Name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lAlertView show];
        [lAlertView release];
    }else{
        if ([self saveUserInfo]) {
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:nil message:@"Save Susses" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [lAlertView show];
            [lAlertView release];
        }else{
            UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Save Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [lAlertView show];
            [lAlertView release];
        }
    }
}
@end
