//
//  MyTextField.h
//  Turboscaffolding
//
//  Created by SOFT on 02/12/14.
//  Copyright (c) 2014 SOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextField : UITextField

- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;

@end