//
//  ViewController.m
//  CarAlwaysWanted
//
//  Created by MacBook on 20/04/2016.
//  Copyright (c) 2016 Datatech. All rights reserved.
//

#import "ViewController.h"
#import <Security/Security.h>
#include <CommonCrypto/CommonCryptor.h>
#include <CommonCrypto/CommonDigest.h>
#import "XMLAPICall.h"
#import "XMLDictionary.h"
#import "NSData+Base64.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "CategoryDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SWRevealViewController.h"
//#import "RegistrationViewController.h"
#import "UIViewController+MJPopupViewController.h"
//#import "PopUpViewController.h"

#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    SWRevealViewController *revealViewController = self.revealViewController;
    if(revealViewController){
        [self.openMenu setTarget:self.revealViewController];
        [self.openMenu setAction:@selector(rightRevealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)btnClicked:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth1 =[ud valueForKey:AUTHKEY];
    if (strAuth1.length <= 0) {
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [XMLAPICall verifyDeviceID:strDeviceId completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            //[DELEGATE hideHUD:YES];
            return ;
        } else {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *strAuth =[NSString stringWithFormat:@"%@",[[data objectForKey:@"data"] objectForKey:@"authKey"]];
            [ud setValue:strAuth forKey:AUTHKEY];
            [ud synchronize];
        }
    }];
    } else {
            NSLog(@"Verification Done");
    }

}
@end
