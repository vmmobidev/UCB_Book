//
//  SlideOutMenuViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SlideOutMenuViewController.h"

@interface SlideOutMenuViewController ()
{
    NSArray *menuList, *listImagesArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;
@end

@implementation SlideOutMenuViewController

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
    
    menuList = @[@"Directory",@"Card View",@"Holiday",@"Location",@"About Us",@"Logout"];
    
    listImagesArr = @[@"ic_directory.png",@"ic_cardView.png",@"ic_holidays.png",@"ic_location.png",@"ic_aboutUs@2x.png",@"ic_logout@2x.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark UITableViewDataSource methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    UILabel *lable = (UILabel *)[cell viewWithTag:100];
    lable.text = menuList[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:200];
    imageView.image = [UIImage imageNamed:listImagesArr[indexPath.row]];
    
    return cell;
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
