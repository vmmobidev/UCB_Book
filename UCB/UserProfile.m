//
//  UserProfile.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (id)init
{
    self = [super init];
    if (self)
    {
        self.reportsTo = 0;
    }
    return self;
}

@end
