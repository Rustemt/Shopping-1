//
//  LoginViewController.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *nameText;
@property (retain, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)textFieldEndExit:(UITextField *)sender;
- (IBAction)registerButtonClick:(UIButton *)sender;
- (IBAction)loginButtonClick:(UIButton *)sender;

@end
