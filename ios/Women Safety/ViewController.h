//
//  ViewController.h
//  Women Safety
//
//  Created by Rakesh P Gopal on 9/11/15.
//  Copyright (c) 2015 Rakshitha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

}

+(ViewController *)vcPhone;
+(ViewController *)vcSecret;
+(ViewController *)vcEmc;


@property (weak, nonatomic) IBOutlet UITextField *txtPhNum;
@property (weak, nonatomic) IBOutlet UITextField *txtSec1;
@property (weak, nonatomic) IBOutlet UITextField *txtSec2;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmc1;
@property (weak, nonatomic) IBOutlet UITextField *txtEmc2;

@property (weak, nonatomic) IBOutlet UILabel *labelSecretNoMatch;

@end

