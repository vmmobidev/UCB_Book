//
//  SlideOutMenuViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SlideOutMenuViewController.h"
#import "AppDelegate.h"

@interface SlideOutMenuViewController ()
{
    NSArray *menuList, *listImagesArr, *menuStoryBordID;
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
    
        menuStoryBordID = @[@"slideOutdirectorySegue", @"slideOutCardViewSegue",@"slideOutHolidaySegue",@"slideOutLocationSegue",@"slideOutdirectorySegue",@"slideOutdirectorySegue"];
    self.currentFrontVCIndex = 0;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableViewOutlet indexPathForSelectedRow];
    NSLog(@"index path %@",indexPath);
    
    UINavigationController *destinationViewController = (UINavigationController*)segue.destinationViewController;
    destinationViewController.title = [menuList objectAtIndex:indexPath.row];
    
    if ([segue isKindOfClass:[SWRevealViewControllerSegue class]])
    {
        SWRevealViewControllerSegue *revelSegue = (SWRevealViewControllerSegue *)segue;
        
        revelSegue.performBlock = ^( SWRevealViewControllerSegue* segue, UIViewController* svc, UIViewController* dvc )
        {
            SWRevealViewController *revelViewCOntroller = self.revealViewController;
            
            //            [dvc.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
            //            [dvc.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
            
            UIButton *navigationDrawerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [navigationDrawerBtn  setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
            navigationDrawerBtn.frame = CGRectMake(0, 0, 30, 18);
            [navigationDrawerBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationDrawerBtn];
            
            dvc.navigationItem.leftBarButtonItem = revealButtonItem;
            
            UINavigationController *naviagtionController = [[UINavigationController alloc] initWithRootViewController:dvc];
            [revelViewCOntroller pushFrontViewController:naviagtionController animated:YES];
        };
    }
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

#pragma mark
#pragma mark UITabBarDelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5)
    {
        AppDelegate *appDel = [UIApplication sharedApplication].delegate;
        UINavigationController *navCon = (UINavigationController *) appDel.window.rootViewController;
//        UIViewController *rootViewC = navCon.viewControllers[0];
        [navCon popToRootViewControllerAnimated:YES];
        return;
    }
    if (self.currentFrontVCIndex != indexPath.row)
    {
        [self performSegueWithIdentifier:menuStoryBordID[indexPath.row] sender:tableView];
    }else
    {
        [self.revealViewController revealToggleAnimated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentFrontVCIndex = indexPath.row;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
