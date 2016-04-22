//
//  MyTextField.m
//  Turboscaffolding
//
//  Created by SOFT on 02/12/14.
//  Copyright (c) 2014 SOFT. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField

static CGFloat leftMargin = 5;

- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.origin.x += leftMargin;
    bounds.size.width -= leftMargin;
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.origin.x += leftMargin;
    bounds.size.width -= leftMargin;
    return bounds;
}

@end