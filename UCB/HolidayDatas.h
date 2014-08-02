//
//  HolidayDatas.h
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface HolidayDatas : NSObject

@property (strong, nonatomic) NSArray *holidayDatas;

+ (id)sharedInstance;
-(NSArray *)getListOfHolidays;

@end
