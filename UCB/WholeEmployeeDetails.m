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
    
    NSArray *arrayOfAllEmployees = serializedJSON[@"UCBEmployee"][@"UCBEmployeeData"];
    NSMutableArray *tempStorage = [[NSMutableArray alloc] init];
    
    for (NSDictionary *anEmployee in arrayOfAllEmployees)
    {
        [tempStorage addObject:[self employeeForDictionary:anEmployee]];
    }
    
    listOfAllEmployees = tempStorage;
    
//    for (UserProfile *aUser in listOfAllEmployees)
//    {
//        for (NSString *reportee in aUser.directReportees)
//        {
//            BOOL found = NO;
//            for (UserProfile *userP in listOfAllEmployees)
//            {
//                if ([userP.employeeID isEqualToString:reportee])
//                {
//                    found = YES;
//                }
//            }
//            
//            if (!found)
//            {
//                NSLog(@"not found %@", reportee);
//            }
//        }
//    }
    
    return listOfAllEmployees;
}

- (UserProfile *)employeeForDictionary:(NSDictionary *)employeeDictionary
{
    UserProfile *employeeDetails = [[UserProfile alloc] init];

//    employeeDetails.profileID = [VALUE_FOR(employeeDictionary[@"ID"]) intValue];
//    employeeDetails.middleName = VALUE_FOR(employeeDictionary[@"MiddleName"]);
//    employeeDetails.gender = VALUE_FOR(employeeDictionary[@"Gender"]);
//    employeeDetails.designation = VALUE_FOR(employeeDictionary[@"Designation"]);

    employeeDetails.firstName = VALUE_FOR(employeeDictionary[@"FirstName"]);
    employeeDetails.lastName = VALUE_FOR(employeeDictionary[@"LastName"]);
    employeeDetails.country = VALUE_FOR(employeeDictionary[@"Country"]);
    employeeDetails.title = VALUE_FOR(employeeDictionary[@"Title"]);
    employeeDetails.company = VALUE_FOR(employeeDictionary[@"Company"]);
    employeeDetails.department = VALUE_FOR(employeeDictionary[@"Department"]);

    employeeDetails.emailID = VALUE_FOR(employeeDictionary[@"Email"]);
    employeeDetails.phoneNo = VALUE_FOR(employeeDictionary[@"Phone"]);
    employeeDetails.mobileNo = VALUE_FOR(employeeDictionary[@"Mobile"]);
    employeeDetails.employeeID = VALUE_FOR(employeeDictionary[@"EmployeeID"]);

    if (employeeDictionary[@"ReportingManagerId"] != [NSNull null])
    {
        employeeDetails.reportsTo = employeeDictionary[@"ReportingManagerId"];
        NSLog(@"employee reports to %@", employeeDetails.reportsTo);
    }else
        employeeDetails.reportsTo = nil;
    
    
    employeeDetails.photoImage = VALUE_FOR(employeeDictionary[@"Photo"]);

    employeeDetails.directReportees = [self giveDirectRepoteesFor:employeeDictionary[@"Reportees"]];
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
    
    UserProfile *CEO_1 = [self userForID:@"U044070"];
//    UserProfile *CEO_2 = [self userForID:10];
    
    [firstTwoLevelEmployees addObjectsFromArray:@[CEO_1]];
    
    [firstTwoLevelEmployees addObjectsFromArray:[self directReporteesFor:CEO_1 InListOfEmployee:nil]];
//    [firstTwoLevelEmployees addObjectsFromArray:[self directReporteesFor:CEO_2 InListOfEmployee:nil]];
    
    return firstTwoLevelEmployees;
}

- (UserProfile *)userForID:(NSString *)employeeID
{
    UserProfile *user = nil;
    
    if (listOfAllEmployees != nil)
    {
        for (user in listOfAllEmployees)
        {
            if ([user.employeeID isEqualToString:employeeID])
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
//        NSInteger reporteeID = [anReporteeID integerValue];
        [array addObject:[self userForID:anReporteeID]];
        NSLog(@"USER.empoyee id = %@", anReporteeID);

    }
    
    return array;
}

@end
