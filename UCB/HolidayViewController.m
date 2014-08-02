//
//  HolidayViewController.m
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "HolidayViewController.h"
#import "HolidayDatas.h"
#import "HolidayDetailsViewController.h"

@interface HolidayViewController ()
{
    NSArray *arrOfHolidayDatas;
    NSArray *countryNameArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@end

@implementation HolidayViewController

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
    
 
    
    NSString *pathCountryName  = [[NSBundle mainBundle] pathForResource:@"UCBLocationCountryList" ofType:@"txt"];
    NSString *countryName = [[NSString alloc] initWithContentsOfFile:pathCountryName
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
    countryNameArr =  [countryName componentsSeparatedByString:@"\r\n"];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableViewOutlet indexPathForSelectedRow];
    
    HolidayDetailsViewController *holidayDetailVC = segue.destinationViewController;
    holidayDetailVC.countryNameFromBackVC = countryNameArr[indexPath.row];
}

#pragma mark
#pragma mark UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [countryNameArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", countryNameArr[indexPath.row]]];

    
    UILabel *lable = (UILabel *)[cell viewWithTag:200];
    lable.text = countryNameArr[indexPath.row];;
    
    
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
