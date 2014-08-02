//
//  WholeEmployeeDetails.h
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserProfile.h"

@interface WholeEmployeeDetails : NSObject

+ (id)sharedInstance;

- (NSArray *)employeeListForData:(NSData *)responseData;
- (NSArray *)firstTwoLevelOfEmployeesForData:(NSData *)responseData;
- (UserProfile *)userForID:(NSInteger)profileID;
- (NSArray *)directReporteesFor:(UserProfile *)user InListOfEmployee:(NSArray *)collectionOfAllEmployees;


@end
