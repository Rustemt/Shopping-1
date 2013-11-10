//
//  AddGoodsViewController.h
//  Shopping
//
//  Created by TY on 13-11-6.
//  Copyright (c) 2013年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGoodsViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIButton *_imageViewButton;
    UITextField *_nameText;
    UITextField *_priceText;
}

@end
