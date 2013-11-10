//
//  AddAddressViewController.h
//  Shopping
//
//  Created by Mingle Chang on 13-11-7.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAddressViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *nameText;//收货人的姓名
@property (retain, nonatomic) IBOutlet UITextField *telephoneText;//收货人的电话
@property (retain, nonatomic) IBOutlet UITextField *addressText;//收货人的地址
- (IBAction)textEndExit:(UITextField *)sender;

@end
