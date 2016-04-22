//
//  SelectYourCar.m
//  CarAlwaysWanted
//
//  Created by MacBook on 22/04/2016.
//  Copyright (c) 2016 Datatech. All rights reserved.
//

#import "SelectYourCar.h"
#import "QuartzCore/QuartzCore.h"
#import "XMLAPICall.h"
#import "XMLDictionary.h"


@interface SelectYourCar ()

@end

@implementation SelectYourCar

- (void)viewDidLoad {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _year =[ud valueForKey:YEAR];
    _make = [ud valueForKey:MAKE];
    _model = [ud valueForKey:MODEL];
    _transmission = [ud valueForKey:TRANSMISSION];
    _cylinder = [ud valueForKey:CYLINDER];
    _body = [ud valueForKey:BODY];
    
    [self findCar];
    
    //self.carList = @[@""];
//    NSLog(@"%@",year);
//    NSLog(@"%@",make);
//    NSLog(@"%@",model);
//    NSLog(@"%@",transmission);
//    NSLog(@"%@",cylinder);
//    NSLog(@"%@",body);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)findCar{
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    [XMLAPICall findcar:strDeviceId authKey:strAuth year:_year make:_make model:_model transmission:_transmission cylinder:_cylinder body:_body  completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        } else {
            NSLog(@"%@",data);
//            self.bodyArray = [[NSMutableArray alloc] init];
//            [self.bodyArray addObject:@"Body type"];
//            
//            NSString *noRecord =[NSString stringWithFormat:@"%@",[[[data objectForKey:@"data"] objectForKey:@"BodyStyle"] objectForKey:@"norecord"]];
//            if([noRecord  isEqual: @"No record"]){
//                NSLog(@"noRecord");
//            } else {
//                
//                NSMutableDictionary *dictCatList = [data objectForKey:@"data"];
//                self.bodyArray = [[dictCatList objectForKey:@"BodyStyle"] objectForKey:@"BodyStyleDescription"];
//                if([self.bodyArray isKindOfClass:[NSMutableArray class]]){
//                    NSLog(@"ARRAY");
//                }else{
//                    NSLog(@"String");
//                    NSString *tempString = self.bodyArray;
//                    self.bodyArray = [[NSMutableArray alloc] init];
//                    [self.bodyArray addObject:@"Body type"];
//                    [self.bodyArray addObject:tempString];
//                }
//                NSLog(@"%@",self.bodyArray);
//            }
            
        }
    }];
}
@end
