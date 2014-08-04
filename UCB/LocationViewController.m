//
//  LocationViewController.m
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "LocationViewController.h"
#import "MapViewController.h"
#import "Location.h"

@interface LocationViewController ()
{
    NSMutableArray  *allLocationdata;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@end

@implementation LocationViewController

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
    
    allLocationdata = [[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ubc_location" ofType:@"js"];
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSArray *locationData = jsonData[@"ucblocation"];
    
    for (NSDictionary *anlocation in locationData) {
        Location *location = [[Location alloc] init];
        location.country = anlocation [@"country"];
        location.companyName = anlocation [@"companyName"];
        location.address = anlocation [@"address"];
        location.telephone = anlocation [@"telephone"];
        location.fax = anlocation [@"fax"];
        location.email = anlocation [@"email"];
        location.webSite = anlocation [@"website"];
        location.latLong = anlocation [@"latAndLong"];

        [allLocationdata addObject:location];
        
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableViewOutlet indexPathForSelectedRow];
    
    MapViewController *mapVC = segue.destinationViewController;
    Location *aLocation = allLocationdata[indexPath.row];
    mapVC.locationSelectedData = aLocation;
    
}

#pragma mark
#pragma mark UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allLocationdata count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *lable = (UILabel *)[cell viewWithTag:100];
    Location *aLocation = allLocationdata[indexPath.row];
    lable.text = aLocation.country;
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
