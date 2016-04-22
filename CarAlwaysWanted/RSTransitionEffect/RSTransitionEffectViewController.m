//
//  RSTransitionEffectViewController.m
//  RSTransitionEffect
//
//  Created by R0CKSTAR on 12/11/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSTransitionEffectViewController.h"

#import "RSBasicItem.h"
#import "CPAnimationSequence.h"
#import "CPAnimationProgram.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSTransitionEffectViewController ()

@property (nonatomic, strong) NSDictionary *targetFrames;

@property (nonatomic, strong) UIColor *backgroundColor;

- (void)__buildTargetFrames;

- (void)__switchToSourceFrames:(BOOL)isSource;

@end

@implementation RSTransitionEffectViewController
@synthesize strProductId;
#pragma mark - Private

- (void)__buildTargetFrames {
    NSMutableDictionary *frames = [NSMutableDictionary dictionary];
    
    [frames setObject:[NSValue valueWithCGRect:self.cell.frame] forKey:@"cell"];
    
    [frames setObject:[NSValue valueWithCGRect:self.imageView.frame] forKey:@"imageView"];
    self.targetFrames = [NSDictionary dictionaryWithDictionary:frames];
}

- (void)__switchToSourceFrames:(BOOL)isSource {
    NSDictionary *frames = nil;
    CGRect toolbarFrame = self.toolbar.frame;
    CGRect tableViewFrame = self.tableview.frame;
    CGRect txtViewFrame =self.txtview.frame;
    if (isSource) {
        frames = self.sourceFrames;
        self.backgroundView.alpha = 1;
        toolbarFrame.origin.y += toolbarFrame.size.height;
        tableViewFrame.origin.y += tableViewFrame.size.height;
        txtViewFrame.origin.y += txtViewFrame.size.height;
        [[CPAnimationSequence sequenceWithSteps:
          [self viewSpecificRevertAnimation],
          nil
          ] run];
        
    } else {
        frames = self.targetFrames;
        self.backgroundView.alpha = 0;
        toolbarFrame.origin.y -= toolbarFrame.size.height;
        tableViewFrame.origin.y -= tableViewFrame.size.height;
        txtViewFrame.origin.y -= txtViewFrame.size.height;
        CPAnimationSequence* animationSequence = [CPAnimationSequence sequenceWithSteps:
                                                  [self viewSpecificStartAnimation],
                                                  nil];
        [animationSequence run];
    }
    self.cell.frame = [[frames objectForKey:@"cell"] CGRectValue];
    self.imageView.frame = [[frames objectForKey:@"imageView"] CGRectValue];
    self.tableview.frame = tableViewFrame;
    self.txtview.frame = txtViewFrame;
    self.toolbar.frame = toolbarFrame;
}

- (CPAnimationStep*) viewSpecificStartAnimation {
	return [CPAnimationSequence sequenceWithSteps:
			[CPAnimationStep after:0.7 for:1.0 animate:^{
        self.tableview.transform = CGAffineTransformMakeScale(2.0, 2.0);
        self.txtview.transform = CGAffineTransformMakeScale(2.0, 2.0);}],
			nil];
}

- (CPAnimationStep*) viewSpecificRevertAnimation {
	// we run two sequences in parallel: stepping backwards through the steps, and moving an indicator arrow.
	return
			[CPAnimationSequence sequenceWithSteps:
             [CPAnimationStep after:0.7 for:1.0 animate:^{
                self.tableview.transform = CGAffineTransformIdentity;
                self.txtview.transform = CGAffineTransformIdentity; }],
             nil];
}

#pragma mark - RSTransitionEffectViewController
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIGraphicsBeginImageContextWithOptions(window.bounds.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [window.layer renderInContext:context];
        self.backgroundColor = [UIColor colorWithPatternImage:UIGraphicsGetImageFromCurrentImageContext()];
        UIGraphicsEndImageContext();
        self.animationDuration = 1.0f;
        self.cellBackgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
	// Do any additional setup after loading the view.
    self.backgroundView.backgroundColor = self.backgroundColor;
    self.cell.backgroundColor = self.cellBackgroundColor;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strAuth =[ud valueForKey:AUTHKEY];
    NSString *strDeviceId = [ud valueForKey:DEVICEID];
    self.strProductId = self.item.strProductId;
    self.imgUrl = self.item.imageUrl;
    self.productName.text = self.item.detailText;
    [self.imageView setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:[UIImage imageNamed:@"DefaultListImage"]];
    self.tableview.delegate =self;
    self.tableview.dataSource =self;
    [XMLAPICall getProductDetail:strDeviceId authKey:strAuth ProductId:self.strProductId completion:^(id data, NSInteger status, NSError *error) {
         if (error || (status != 200)) {
             UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
             return ;
             
         } else {
             self.arrProductDetail = data;
             self.dictProductDetail = [data objectForKey:@"data"];
             self.arrAttributes = [[[data objectForKey:@"data"] objectForKey:@"attributes"] objectForKey:@"attribute"];
             [self.tableview reloadData];
             
         }
     }];

    // [self __bindItem];
        [self __buildTargetFrames];
    [self __switchToSourceFrames:YES];
    [self.tableview reloadData];
    //self.tableview.hidden = YES;
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self __switchToSourceFrames:NO];
        //self.tableview.hidden = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self __switchToSourceFrames:YES];
        //self.tableview.hidden = YES;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            self.cell.alpha = 0;
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count =(int)[[self.dictProductDetail objectForKey:@"noOfAttributes"] integerValue];
    if (count > 0) {
        return count;
    } else
      return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString		*CellIdentifier	= @"ProductCustomCell";
    UITableViewCell *cell =(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end