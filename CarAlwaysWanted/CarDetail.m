//
//  CarDetail.m
//  CarAlwaysWanted
//
//  Created by MacBook on 20/04/2016.
//  Copyright (c) 2016 Datatech. All rights reserved.
//

#import "CarDetail.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "XMLAPICall.h"
#import "XMLDictionary.h"

@interface CarDetail ()

@end

@implementation CarDetail


@synthesize yearBtn;
@synthesize yearArray;

@synthesize makeBtn;
@synthesize makeArray;

@synthesize modelBtn;
@synthesize modelArray;

@synthesize transmissionBtn;
@synthesize transmissionArray;

@synthesize cylinderBtn;
@synthesize cylinderArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //year part
    self.yearArray = [[NSMutableArray alloc] init];
    [self.yearArray addObject:@"Year of manufacture"];
    [self getYear];
    
    yearBtn.layer.borderWidth = 1;
    yearBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    yearBtn.layer.cornerRadius = 5;
    
    //make part
    self.makeArray = [[NSMutableArray alloc] init];
    [self.makeArray addObject:@"Car make"];
    
    makeBtn.layer.borderWidth = 1;
    makeBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    makeBtn.layer.cornerRadius = 5;

    //model part
    self.modelArray = [[NSMutableArray alloc] init];
    [self.modelArray addObject:@"Car model"];

    modelBtn.layer.borderWidth = 1;
    modelBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    modelBtn.layer.cornerRadius = 5;
    
    //transmission part
    self.transmissionArray = [[NSMutableArray alloc] init];
    [self.transmissionArray addObject:@"Transmission type"];
    [self.transmissionArray addObject:@"Auto"];
    [self.transmissionArray addObject:@"Manual"];
    
    transmissionBtn.layer.borderWidth = 1;
    transmissionBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    transmissionBtn.layer.cornerRadius = 5;
    
    //cylinder part
    self.cylinderArray = [[NSMutableArray alloc] init];
    [self.cylinderArray addObject:@"Number of cylinder"];
    
    cylinderBtn.layer.borderWidth = 1;
    cylinderBtn.layer.borderColor = [[UIColor blackColor] CGColor];
    cylinderBtn.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    //    [btnSelect release];
    
    yearBtn = nil;
    [self setYearBtn:nil];
    
    makeBtn = nil;
    [self setMakeBtn:nil];
    
    modelBtn = nil;
    [self setModelBtn:nil];
    
    transmissionBtn = nil;
    [self setTransmissionBtn:nil];
    
    cylinderBtn = nil;
    [self setCylinderBtn:nil];
    
    
    [super viewDidUnload];
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


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    if(sender == makeDropDown){
        [self relMake];
    }
    if(sender == dropDown){
        [self rel];
    }
    if(sender == modelDropDown){
        [self relModel];
    }
    if(sender == transmissionDropDown){
        [self relTransmission];
    }
    if(sender == cylinderDropDown){
        [self relCylinder];
    }
    
    
    
}


- (IBAction)openYearDropDown:(id)sender {
    
    
    NSArray *myArray = [self.yearArray copy];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :myArray :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

-(void)rel{
    //    [dropDown release];
    
    dropDown = nil;
    if(![yearBtn.currentTitle  isEqual: @"Year of manufacture"]){
        //NSLog(@"%@",yearBtn.currentTitle);
        [self getMake];
    } else {
       
    }
    
}

-(void)getYear{
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    [XMLAPICall getYear:strDeviceId authKey:strAuth completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        } else {
            NSString *minyear =[NSString stringWithFormat:@"%@",[[data objectForKey:@"data"] objectForKey:@"minyear"]];
            NSString *maxyear =[NSString stringWithFormat:@"%@",[[data objectForKey:@"data"] objectForKey:@"maxyear"]];
            
            NSInteger minyearInt = [minyear integerValue];
            NSInteger maxyearInt = [maxyear integerValue];

            self.yearArray = [[NSMutableArray alloc] init];
            [self.yearArray addObject:@"Year of manufacture"];
            for(int i = minyearInt; i < maxyearInt; i++){
                [self.yearArray addObject:[NSString stringWithFormat:@"%i", i]];
            }
        }
    }];
}



- (IBAction)openMakeDropDown:(id)sender {
    NSArray *myArray = [self.makeArray copy];
    if(makeDropDown == nil) {
        CGFloat f = 200;
        makeDropDown = [[NIDropDown alloc]showDropDown:sender :&f :myArray :nil :@"down"];
        makeDropDown.delegate = self;
        
        makeDropDown.userInteractionEnabled=YES;
        
        
        
    //    NSLog(@"%@", makeBtn.currentTitle);
    }
    else {
        [makeDropDown hideDropDown:sender];
        [self relMake];
    }
}

-(void)relMake{
    //    [dropDown release];
    makeDropDown = nil;
    if(![makeBtn.currentTitle  isEqual: @"Car make"]){
        NSLog(@"%@",makeBtn.currentTitle);
        [self getModel];
    } else {
        
    }
}

-(void)getMake{
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    [XMLAPICall getMake:strDeviceId authKey:strAuth year:yearBtn.currentTitle completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        } else {
            //NSLog(@"%@",data);
            self.makeArray = [[NSMutableArray alloc] init];
            [self.makeArray addObject:@"Car Make"];
            NSMutableDictionary *dictCatList = [data objectForKey:@"data"];
            self.makeArray = [[dictCatList objectForKey:@"make"] objectForKey:@"makename"];
            //NSLog(@"%@",self.makeArray);
            
        }
    }];
}


- (IBAction)openModelDropDown:(id)sender {
    NSArray *myArray = [self.modelArray copy];
    if(modelDropDown == nil) {
        CGFloat f = 200;
        modelDropDown = [[NIDropDown alloc]showDropDown:sender :&f :myArray :nil :@"down"];
        modelDropDown.delegate = self;
        
        modelDropDown.userInteractionEnabled=YES;
    }
    else {
        [modelDropDown hideDropDown:sender];
        [self relModel];
    }
}

-(void)getModel{
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    [XMLAPICall getModel:strDeviceId authKey:strAuth year:yearBtn.currentTitle make:makeBtn.currentTitle completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        } else {
            //NSLog(@"%@",data);
            self.modelArray = [[NSMutableArray alloc] init];
            [self.modelArray addObject:@"Car Model"];
            NSMutableDictionary *dictCatList = [data objectForKey:@"data"];
            self.modelArray = [[dictCatList objectForKey:@"model"] objectForKey:@"modelname"];
            NSLog(@"%@",self.modelArray);
            
        }
    }];
}

-(void)relModel{
    //    [dropDown release];
    modelDropDown = nil;
    if(![modelBtn.currentTitle  isEqual: @"Car model"]){
        NSLog(@"%@",modelBtn.currentTitle);
    } else {
        
    }
}


- (IBAction)openTransmissionDropDown:(id)sender {
    NSArray *myArray = [self.transmissionArray copy];
    if(transmissionDropDown == nil) {
        CGFloat f = 200;
        transmissionDropDown = [[NIDropDown alloc]showDropDown:sender :&f :myArray :nil :@"down"];
        transmissionDropDown.delegate = self;
        
        transmissionDropDown.userInteractionEnabled=YES;
        
        
        
        //    NSLog(@"%@", makeBtn.currentTitle);
    }
    else {
        [transmissionDropDown hideDropDown:sender];
        [self relTransmission];
    }
}

-(void)relTransmission{
    //    [dropDown release];
    transmissionDropDown = nil;
    if(![transmissionBtn.currentTitle  isEqual: @"Transmission type"]){
        [self getCylinder];
    } else {
        
    }
}

-(void)relCylinder{
    //    [dropDown release];
    cylinderDropDown = nil;
    if(![cylinderBtn.currentTitle  isEqual: @"Car make"]){
        NSLog(@"%@",cylinderBtn.currentTitle);
        //[self getModel];
    } else {
        
    }
}

-(void)getCylinder{
    NSString *strDeviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    [XMLAPICall getCylinder:strDeviceId authKey:strAuth year:yearBtn.currentTitle make:makeBtn.currentTitle model:modelBtn.currentTitle transmission:transmissionBtn.currentTitle completion:^(id data, NSInteger status, NSError *error) {
        if (error || (status != 200)) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return ;
        } else {
            NSLog(@"test %@",data);
            /*self.cylinderArray = [[NSMutableArray alloc] init];
            [self.cylinderArray addObject:@"Car Make"];
            NSMutableDictionary *dictCatList = [data objectForKey:@"data"];
            self.cylinderArray = [[dictCatList objectForKey:@"make"] objectForKey:@"makename"];*/
            //NSLog(@"%@",self.makeArray);
            
        }
    }];
}

- (IBAction)openCylinderDropDown:(id)sender {
    NSArray *myArray = [self.cylinderArray copy];
    if(cylinderDropDown == nil) {
        CGFloat f = 200;
        cylinderDropDown = [[NIDropDown alloc]showDropDown:sender :&f :myArray :nil :@"down"];
        cylinderDropDown.delegate = self;
        
        cylinderDropDown.userInteractionEnabled=YES;
        
        
        
        //    NSLog(@"%@", makeBtn.currentTitle);
    }
    else {
        [cylinderDropDown hideDropDown:sender];
        [self relCylinder];
    }
}
@end
