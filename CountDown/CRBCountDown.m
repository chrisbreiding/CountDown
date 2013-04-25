//
//  CRBCountDown.m
//  CountDown
//
//  Created by CB on 04/22/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBCountDown.h"

@implementation CRBCountDown

- (id)init {
    self = [super init];
    if (self) {
        self.daysLeft = @0;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.daysLeft = [coder decodeObjectForKey:@"daysLeft"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.daysLeft forKey:@"daysLeft"];
}

@end
