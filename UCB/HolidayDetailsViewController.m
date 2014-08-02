//
//  HolidayDetailsViewController.m
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "HolidayDetailsViewController.h"
#import "HolidayDatas.h"
#import "Holiday.h"

@interface HolidayDetailsViewController ()
{
    NSArray *arrOfHolidayDatas;
    NSMutableArray *holidayNameArr,*dayArr,*dateArr;

}
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@end

@implementation HolidayDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    holidayNameArr = [[NSMutableArray alloc] init];
    dayArr = [[NSMutableArray alloc] init];
    dateArr = [[NSMutableArray alloc] init];

    
    arrOfHolidayDatas = [[HolidayDatas sharedInstance] getListOfHolidays];
    
    for (Holiday *holiday in arrOfHolidayDatas) {
        if ([self.countryNameFromBackVC caseInsensitiveCompare:holiday.countryName]==NSOrderedSame)
        {
            [holidayNameArr addObject:holiday.holidayName];
            [dateArr addObject:holiday.date];
            [dayArr addObject:holiday.day];
        }
    }
    
}

#pragma mark
#pragma mark UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [holidayNameArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    UILabel *lable = (UILabel *)[cell viewWithTag:100];
    lable.text = holidayNameArr[indexPath.row];
    
    UILabel *lableforDate = (UILabel *)[cell viewWithTag:200];
    lableforDate.text = dateArr[indexPath.row];
    

    UILabel *lableforday = (UILabel *)[cell viewWithTag:300];
    NSString *nameForCell = [[NSString alloc]init];
    nameForCell = dayArr[ indexPath.row];
    nameForCell =[nameForCell substringToIndex:3];
    lableforday.text = nameForCell;
    
    
    
    return cell;
}

#pragma mark
#pragma mark UITabBarDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
