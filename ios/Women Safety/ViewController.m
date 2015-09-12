//
//  ViewController.m
//  Women Safety
//
//  Created by Rakesh P Gopal on 9/11/15.
//  Copyright (c) 2015 Rakshitha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *ph = [[NSUserDefaults standardUserDefaults] valueForKey:@"ph_number"];
    
    if (ph) {
        // registered
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static ViewController *vcPhone;
static ViewController *vcSecret;
static ViewController *vcEmc;

extern NSString *name;
extern NSString *ph_number;
extern NSString *secret;
extern NSString *emc1;
extern NSString *emc2;

- (IBAction)btnRegisterNext:(id)sender {
    ph_number = self.txtPhNum.text;
    name = self.txtUserName.text;
    
    vcPhone = self;
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = vcSecret = (ViewController*)[mainSB instantiateViewControllerWithIdentifier:@"vcSecNum"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnSecretNumNext:(id)sender {
    NSString *s1 = self.txtSec1.text;
    NSString *s2 = self.txtSec2.text;
    
    if ([s1 isEqualToString:s2]) {
        self.labelSecretNoMatch.hidden = YES;
        secret = s1;
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *vc = vcEmc = (ViewController*)[mainSB instantiateViewControllerWithIdentifier:@"vcEMC"];
    
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        self.labelSecretNoMatch.hidden = NO;
    }

}

- (IBAction)btnEMCNext:(id)sender {
    emc1 = self.txtEmc1.text;
    emc2 = self.txtEmc2.text;
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = (ViewController*)[mainSB instantiateViewControllerWithIdentifier:@"vcIntro1"];
    
    NSString *query = @"register/?";
    query = [query stringByAppendingString: [@"name=" stringByAppendingString:name]];
    query = [query stringByAppendingString: [@"&ph_number=" stringByAppendingString:ph_number]];
    query = [query stringByAppendingString: [@"&secret=" stringByAppendingString:secret]];
    query = [query stringByAppendingString: [@"&emc1=" stringByAppendingString:emc1]];
    query = [query stringByAppendingString: [@"&emc2=" stringByAppendingString:emc2]];
    
    NSDictionary *res = [self getFromServer:query];
    if ([res[@"status"] isEqualToString:@"ok"]) {
        [[NSUserDefaults standardUserDefaults] setValue:ph_number forKey:@"ph_number"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnEMCBack:(id)sender {
    [self presentViewController:vcSecret animated:YES completion:nil];
}

- (IBAction)btnSecBack:(id)sender {
    [self presentViewController:vcPhone animated:YES completion:nil];
}

- (IBAction)btnIntro1Done:(id)sender {
    exit(0);
}


- (NSDictionary *)getFromServer:(NSString*)params {
    NSString *strUrl = [@"http://ec2-52-88-193-129.us-west-2.compute.amazonaws.com:10001/" stringByAppendingString: params];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:strUrl]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    NSString *strRes = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    if(error) { /* JSON was malformed, act appropriately here */ }
    
    // the originating poster wants to deal with dictionaries;
    // assuming you do too then something like this is the first
    // validation step:
    if([object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }

    return nil;
}

/*
- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - kTabBarHeight);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}
*/

@end
