//
//  WholeEmployeeDetails.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "WholeEmployeeDetails.h"

@implementation WholeEmployeeDetails

- (NSArray *)employeeListForData:(NSData *)responseData
{
    NSArray *listOfAllEmployees;
    
    NSDictionary *serializedJSON;
    serializedJSON = [NSJSONSerialization JSONObjectWithData:responseData
                                                     options:kNilOptions
                                                       error:Nil];
    
    
    NSArray *arrayOfAllEmployees = serializedJSON[@"aaData"][@"Employees"];
    NSMutableArray *tempStorage = [[NSMutableArray alloc] init];
    
    for (NSDictionary *anEmployee in arrayOfAllEmployees)
    {
        [tempStorage addObject:[self employeeForDictionary:anEmployee]];
    }
    
    return listOfAllEmployees;
}

- (UserProfile *)employeeForDictionary:(NSDictionary *)employeeDictionary
{
    UserProfile *employeeDetails = [[UserProfile alloc] init];
    
    employeeDetails.profileID = [(NSNumber *)employeeDictionary[@"ID"] intValue];
    employeeDetails.firstName = employeeDictionary[@"FirstName"];
    employeeDetails.middleName = employeeDictionary[@"MiddleName"];
    employeeDetails.lastName = employeeDictionary[@"LastName"];
    employeeDetails.emailID = employeeDictionary[@"Email"];
    employeeDetails.phoneNo = employeeDictionary[@"Phone"];
    employeeDetails.mobileNo = employeeDictionary[@"Mobile"];
    employeeDetails.gender = employeeDictionary[@"Gender"];
    employeeDetails.employeeID = employeeDictionary[@"EmployeeID"];
    employeeDetails.designation = employeeDictionary[@"Designation"];

    employeeDetails.reportsTo = [(NSNumber *)employeeDictionary[@"fkReportsTo"] intValue];
    
    employeeDetails.directReportees = [self giveDirectRepoteesFor:employeeDictionary[@"DirectReportees"]];
    return employeeDetails;
}

- (NSArray *)giveDirectRepoteesFor:(NSString *)strngOfList
{
    NSMutableArray *listOfDirectReportees = [[NSMutableArray alloc] init];
    
    listOfDirectReportees = [strngOfList componentsSeparatedByString:@","];
    
    return listOfDirectReportees;
}

@end
