//
//  HolidayDatas.m
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "HolidayDatas.h"
#import "Holiday.h"


@implementation HolidayDatas

{
    sqlite3 *holidaysDB;
    NSString *dbPath;
}


- (id)init {
    if ((self = [super init])) {
    }
    return self;
}

+ (id)sharedInstance
{
    static HolidayDatas *sharedDatabaseManager = Nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDatabaseManager = [[HolidayDatas alloc] init];
    });
    return sharedDatabaseManager;
}

- (NSArray *)holidayDatas
{
    if (!_holidayDatas)
    {
        _holidayDatas = [[NSArray alloc] init];
    }
    
    return _holidayDatas;
}

-(NSArray *)getListOfHolidays
{
//    NSString *pathOfImg  = [[NSBundle mainBundle] pathForResource:@"UCBLocationCountryList" ofType:@"txt"];
//    NSString *imgName = [[NSString alloc] initWithContentsOfFile:pathOfImg
//                                                   encoding:NSUTF8StringEncoding
//                                                      error:nil];
//    NSArray *imgNameArr =  [imgName componentsSeparatedByString:@"\r\n"];
    
    
    dbPath = [[NSBundle mainBundle ] pathForResource:@"holidays" ofType:@"db"];
    NSMutableArray *holidayDataArr = [[NSMutableArray alloc] init];
    if (sqlite3_open([dbPath UTF8String], &holidaysDB)==SQLITE_OK) {
        NSString *query = @"SELECT * FROM UCBLocationNationalHoliday";
        sqlite3_stmt *statment ;
        if (sqlite3_prepare_v2(holidaysDB, [query UTF8String], -1, &statment, Nil)==SQLITE_OK) {
            while (sqlite3_step(statment)== SQLITE_ROW) {
                Holiday *holiday = [[Holiday alloc] init];
                
                holiday.year = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 1)];
                holiday.countryName = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 2)];
//                for (NSString *fileName in imgNameArr)
//                {
//                    if ([fileName caseInsensitiveCompare:holiday.countryName] == NSOrderedSame)
//                    {
//                        holiday.flagImgName = [NSString stringWithFormat:@"%@.jpg",fileName];
//                        break;
//                    }
//                }
                holiday.day = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 3)];
                holiday.date = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 4)];
                holiday.holidayName = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statment, 5)];

                [holidayDataArr addObject:holiday];
            }
            sqlite3_finalize(statment);
        }
        else
            NSLog(@"Failed Preperation");
        sqlite3_close(holidaysDB);
    }
    
    _holidayDatas = holidayDataArr;
    NSLog(@"%i", holidayDataArr.count);
    return holidayDataArr;
}

@end
