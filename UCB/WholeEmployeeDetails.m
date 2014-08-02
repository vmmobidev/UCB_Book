//
//  WholeEmployeeDetails.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "WholeEmployeeDetails.h"
#define VALUE_FOR(x) [x isEqual:[NSNull null]]?nil:x

@implementation WholeEmployeeDetails
{
    NSArray *listOfAllEmployees;
}


+ (id)sharedInstance
{
    static WholeEmployeeDetails *wholeEmployeeDetails = Nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        wholeEmployeeDetails = [[WholeEmployeeDetails alloc] init];
    });
    return wholeEmployeeDetails;
}

- (NSArray *)employeeListForData:(NSData *)responseData
{
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
    
    listOfAllEmployees = tempStorage;
    
    return listOfAllEmployees;
}

- (UserProfile *)employeeForDictionary:(NSDictionary *)employeeDictionary
{
    UserProfile *employeeDetails = [[UserProfile alloc] init];

    employeeDetails.profileID = [VALUE_FOR(employeeDictionary[@"ID"]) intValue];
    employeeDetails.firstName = VALUE_FOR(employeeDictionary[@"FirstName"]);
    employeeDetails.middleName = VALUE_FOR(employeeDictionary[@"MiddleName"]);
    employeeDetails.lastName = VALUE_FOR(employeeDictionary[@"LastName"]);
    employeeDetails.emailID = VALUE_FOR(employeeDictionary[@"Email"]);
    employeeDetails.phoneNo = VALUE_FOR(employeeDictionary[@"Phone"]);
    employeeDetails.mobileNo = VALUE_FOR(employeeDictionary[@"Mobile"]);
    employeeDetails.gender = VALUE_FOR(employeeDictionary[@"Gender"]);
    employeeDetails.employeeID = VALUE_FOR(employeeDictionary[@"EmployeeID"]);
    employeeDetails.designation = VALUE_FOR(employeeDictionary[@"Designation"]);

    employeeDetails.reportsTo = [VALUE_FOR(employeeDictionary[@"fkReportsTo"]) intValue];
    
    employeeDetails.directReportees = [self giveDirectRepoteesFor:employeeDictionary[@"DirectReportees"]];
    return employeeDetails;
}

- (NSArray *)giveDirectRepoteesFor:(NSString *)strngOfList
{
    if ([strngOfList isEqual:[NSNull null]])
    {
        return nil;
    }
    
    NSMutableArray *listOfDirectReportees = [[NSMutableArray alloc] init];
    listOfDirectReportees = [[strngOfList componentsSeparatedByString:@","] mutableCopy];
    return listOfDirectReportees;
}

- (NSArray *)firstTwoLevelOfEmployeesForData:(NSData *)responseData
{
    NSMutableArray *firstTwoLevelEmployees = [[NSMutableArray alloc] init];
    if ((responseData != nil) || (listOfAllEmployees == nil))
    {
        NSLog(@"listOfAllEmployees is nil otherwise responseData not equal to nil");
        listOfAllEmployees = [self employeeListForData:responseData];
    }
    
    UserProfile *CEO_1 = [self userForID:8];
    UserProfile *CEO_2 = [self userForID:10];
    
    [firstTwoLevelEmployees addObjectsFromArray:@[CEO_1, CEO_2]];
    
    [firstTwoLevelEmployees addObjectsFromArray:[self directReporteesFor:CEO_1 InListOfEmployee:nil]];
    [firstTwoLevelEmployees addObjectsFromArray:[self directReporteesFor:CEO_2 InListOfEmployee:nil]];
    
    return firstTwoLevelEmployees;
}

- (UserProfile *)userForID:(NSInteger)profileID
{
    UserProfile *user;
    
    if (listOfAllEmployees != nil)
    {
        for (user in listOfAllEmployees)
        {
            if (user.profileID == profileID)
            {
                break;
            }
        }
    }else
    {
        NSLog(@"Please call 'employeeListForData' method");
    }
    return user;
}

- (NSArray *)directReporteesFor:(UserProfile *)user InListOfEmployee:(NSArray *)collectionOfAllEmployees
{
    if (listOfAllEmployees == nil)
    {
        NSLog(@"listOfAllEmployees is equal to nil");
        listOfAllEmployees = collectionOfAllEmployees;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSString *anReporteeID in user.directReportees)
    {
        NSInteger reporteeID = [anReporteeID integerValue];
        [array addObject:[self userForID:reporteeID]];
    }
    
    return array;
}

@end
