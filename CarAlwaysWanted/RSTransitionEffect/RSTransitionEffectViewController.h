//
//  RSTransitionEffectViewController.h
//  RSTransitionEffect
//
//  Created by R0CKSTAR on 12/11/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSBasicItem;
@class CPAnimationSequence;

@interface RSTransitionEffectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSDictionary *sourceFrames;

@property (nonatomic, strong) RSBasicItem *item;

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, copy) UIColor *cellBackgroundColor;

#pragma mark - IB

@property (nonatomic, weak) IBOutlet UIView *cell;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@property (nonatomic, weak) IBOutlet UIView *backgroundView;

@property (nonatomic, weak) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,weak) IBOutlet UITextView *txtview;

@property(nonatomic,weak) IBOutlet UILabel *productName;
@property(nonatomic,retain) NSString *strProductId;
@property(nonatomic,retain) NSMutableArray *arrProductDetail;
@property(nonatomic,retain) NSMutableDictionary *dictProductDetail;
@property(nonatomic,retain) NSString *imgUrl;
@property(nonatomic,retain) NSMutableArray *arrAttributes;

- (IBAction)close:(id)sender;

@end