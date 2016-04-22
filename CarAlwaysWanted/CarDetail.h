//
//  CarDetail.h
//  CarAlwaysWanted
//
//  Created by MacBook on 20/04/2016.
//  Copyright (c) 2016 Datatech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface CarDetail : UIViewController <NIDropDownDelegate>
{
    
    __weak IBOutlet UIButton *yearBtn;
    NIDropDown *dropDown;
    
    __weak IBOutlet UIButton *makeBtn;
    NIDropDown *makeDropDown;
    
    __weak IBOutlet UIButton *modelBtn;
    NIDropDown *modelDropDown;
    
    __weak IBOutlet UIButton *transmissionBtn;
    NIDropDown *transmissionDropDown;
    
    __weak IBOutlet UIButton *cylinderBtn;
    NIDropDown *cylinderDropDown;
    
    __weak IBOutlet UIButton *bodyBtn;
    NIDropDown *bodyDropDown;
    
}

//year
- (IBAction)openYearDropDown:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (nonatomic, retain) NSMutableArray *yearArray;

//make
- (IBAction)openMakeDropDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *makeBtn;
@property (nonatomic, retain) NSMutableArray *makeArray;

//model
- (IBAction)openModelDropDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *modelBtn;
@property (nonatomic, retain) NSMutableArray *modelArray;


//transmission
- (IBAction)openTransmissionDropDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *transmissionBtn;
@property (nonatomic, retain) NSMutableArray *transmissionArray;

//cylinder
- (IBAction)openCylinderDropDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cylinderBtn;
@property (nonatomic, retain) NSMutableArray *cylinderArray;

//body type
- (IBAction)openBodyDropDown:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *bodyBtn;
@property (nonatomic, retain) NSMutableArray *bodyArray;

//find you car btn
- (IBAction)findYourCar;
@end
