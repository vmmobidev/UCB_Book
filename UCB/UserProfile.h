//
//  UserProfile.h
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject

@property (assign, nonatomic) NSInteger profileID;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *middleName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *emailID;
@property (strong, nonatomic) NSString *phoneNo;
@property (strong, nonatomic) NSString *mobileNo;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *employeeID;
@property (strong, nonatomic) NSString *designation;

@property (assign, nonatomic) NSInteger reportsTo;

@property (strong, nonatomic) NSArray *directReportees;

@end
