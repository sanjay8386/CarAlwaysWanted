//
//  SelectYourCar.h
//  CarAlwaysWanted
//
//  Created by MacBook on 22/04/2016.
//  Copyright (c) 2016 Datatech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectYourCar : UIViewController<UITableViewDelegate,UITableViewDataSource>

//@property (copy, nonatomic) NSMutableArray *carList;
@property (copy, nonatomic) NSArray *carList;

@property NSString *year;
@property NSString *make;
@property NSString *model;
@property NSString *transmission;
@property NSString *cylinder;
@property NSString *body;
@end
