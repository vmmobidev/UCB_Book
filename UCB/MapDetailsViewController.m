//
//  MapDetailsViewController.m
//  UCB
//
//  Created by Vmoksha on 04/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "MapDetailsViewController.h"

@interface MapDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countryName;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *fax;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UIButton *website;


@end

@implementation MapDetailsViewController

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
    
     self.countryName.text = self.detailsOfMap.country;
    self.companyName.text = self.detailsOfMap.companyName;
    self.address.text = self.detailsOfMap.address;
    self.telephone.text = self.detailsOfMap.telephone;
    self.fax.text = self.detailsOfMap.fax;
    self.email.text = self.detailsOfMap.email;
    [self.website setTitle:self.detailsOfMap.webSite forState:UIControlStateNormal];
}
- (IBAction)webSiteBtnAction:(id)sender {
    [[UIApplication  sharedApplication] openURL:[NSURL URLWithString:self.detailsOfMap.webSite]];
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
