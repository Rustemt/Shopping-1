//
//  AddGoodsViewController.m
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import "AddGoodsViewController.h"
#import "Goods.h"
@interface AddGoodsViewController ()

@end

@implementation AddGoodsViewController

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
    _imageViewButton=[[UIButton alloc]initWithFrame:CGRectMake(130, 40, 60, 60)];
    [_imageViewButton setImage:[self defaultImage] forState:UIControlStateNormal];
    [_imageViewButton addTarget:self action:@selector(imageViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imageViewButton];
    
    UILabel *lNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 120, 90, 30)];
    [lNameLabel setText:@"NAME:"];
    [self.view addSubview:lNameLabel];
    [lNameLabel release];
    
    _nameText=[[UITextField alloc]initWithFrame:CGRectMake(160, 120, 130, 30)];
    [_nameText setBorderStyle:UITextBorderStyleRoundedRect];
    [_nameText addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_nameText];
    
    UILabel *lPriceLabel1=[[UILabel alloc]initWithFrame:CGRectMake(60, 170, 90, 20)];
    [lPriceLabel1 setText:@"PRICE:"];
    [self.view addSubview:lPriceLabel1];
    [lPriceLabel1 release];
    
    _priceText=[[UITextField alloc]initWithFrame:CGRectMake(160, 170, 130,30)];
    [_priceText setBorderStyle:UITextBorderStyleRoundedRect];
    [_priceText addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_priceText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [_imageViewButton release];
    [_nameText release];
    [_priceText release];
    [super dealloc];
}
#pragma mark - Private Method
-(void)textFieldEnd:(UITextField *)sender{
    
}
-(UIImage *)defaultImage{
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    UIBezierPath *lBezerPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor redColor]setFill];
    [lBezerPath fill];
    UIBezierPath *lBezerPath1=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 30, 20, 20)];
    [[UIColor yellowColor]setFill];
    [lBezerPath1 fill];
    UIBezierPath *lBezerPath2=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(70, 30, 20, 20)];
    [[UIColor yellowColor]setFill];
    [lBezerPath2 fill];
    UIBezierPath *lBezerPath3=[UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:40 startAngle:45.0/180*M_PI endAngle:135.0/180*M_PI clockwise:YES];
    [[UIColor yellowColor]setStroke];
    [lBezerPath3 stroke];
    
    UIBezierPath *lBezerPath4=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(45, 45, 10, 10)];
    [[UIColor yellowColor]setFill];
    [lBezerPath4 fill];
    
    NSString *lDefaultString=@"Default";
    [[UIColor blackColor]setFill];
    [lDefaultString drawAtPoint:CGPointMake(15, 50) withFont:[UIFont systemFontOfSize:24]];
    
    UIImage *lImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return lImage;
}
-(void)imageViewButtonClick:(UIButton *)sender{
    UIActionSheet *lActionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"PhotoLibrary" otherButtonTitles:@"Camera", nil];
    [lActionSheet showInView:self.view];
    [lActionSheet release];
}
-(BOOL)checkSameName{
    NSFetchRequest *lRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *lEntityDecription=[NSEntityDescription entityForName:@"Goods" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
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
-(BOOL)saveGoodsInfo{
    Goods *lGoods=(Goods *)[NSEntityDescription insertNewObjectForEntityForName:@"Goods" inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext];
    [lGoods setImage:[_imageViewButton imageForState:UIControlStateNormal]];
    [lGoods setName:_nameText.text];
    [lGoods setPrice:[NSNumber numberWithDouble:[_priceText.text doubleValue]]];
    
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
        if ([self saveGoodsInfo]) {
            _nameText.text=@"";
            _priceText.text=@"";
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
#pragma mark - ActionSheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            NSLog(@"First");
            UIImagePickerController *lPickerController=[[UIImagePickerController alloc]init];
            lPickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            lPickerController.delegate=self;
            [self.navigationController presentViewController:lPickerController animated:YES completion:nil];
            [lPickerController release];
            break;
        }
        case 1:{
            NSLog(@"Second");
            UIImagePickerController *lPickerController=[[UIImagePickerController alloc]init];
            lPickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:lPickerController animated:YES completion:nil];
            [lPickerController release];
            break;
        }
        default:
            break;
    }
}
#pragma mark - ImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImage *lImage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
        CATransition *lTransition=[CATransition animation];
        [lTransition setDuration:0.5];
        lTransition.delegate=self;
        [lTransition setType:@"rippleEffect"];
        [lTransition setSubtype:kCATransitionFromLeft];
        [_imageViewButton.imageView.layer addAnimation:lTransition forKey:@"animation"];
        [_imageViewButton setImage:lImage forState:UIControlStateNormal];
    }];
}
@end
