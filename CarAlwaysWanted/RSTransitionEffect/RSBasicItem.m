//
//  RSBasicListItem.m
//  RSTransitionEffect
//
//  Created by R0CKSTAR on 12/12/13.
//  Copyright (c) 2013 P.D.Q. All rights reserved.
//

#import "RSBasicItem.h"

@implementation RSBasicItem

@synthesize arrAttributes = _arrAttributes;

- (id)init {
    
    if ((self = [super init])) {
        self.arrAttributes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.strProductId forKey:@"productid"];
    [encoder encodeObject:self.detailText forKey:@"productname"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.arrAttributes forKey:@"AttributesArray"];
    [encoder encodeBool:self.open forKey:@"open"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.strProductId = [decoder decodeObjectForKey:@"productid"];
        self.detailText = [decoder decodeObjectForKey:@"productname"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.arrAttributes =[decoder decodeObjectForKey:@"AttributesArray"];
        self.open = [decoder decodeBoolForKey:@"open"];
    }
    return self;
}

@end