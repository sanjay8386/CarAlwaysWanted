//
//  RSBasicListItem.h
//  RSTransitionEffect
//
//  Created by R0CKSTAR on 12/12/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSBasicItem : NSObject<NSCoding>

@property (nonatomic, copy) NSString *strProductId;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *detailText;

//@property(nonatomic,copy)UIImage *image;

@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy) NSString *strProductDesc;

@property (nonatomic, retain) NSMutableArray *arrAttributes;

@property (getter = isOpen) BOOL open;

@end