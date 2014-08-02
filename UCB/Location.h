//
//  Location.h
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic)NSString *country;
@property (strong, nonatomic)NSString *companyName;
@property (strong, nonatomic)NSString *address;
@property (strong, nonatomic)NSString *telephone;
@property (strong, nonatomic)NSString *fax;
@property (strong, nonatomic)NSString *email;
@property (strong, nonatomic)NSString *webSite;
@property (strong, nonatomic)NSString *latLong;


@end
