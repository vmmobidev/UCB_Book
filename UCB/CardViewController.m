//
//  CardViewController.m
//  UCB
//
//  Created by Vmoksha on 01/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

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
    
    UIButton *navigationDrawerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigationDrawerBtn  setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    navigationDrawerBtn.frame = CGRectMake(0, 0, 30, 18);
    [navigationDrawerBtn addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationDrawerBtn];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    self.title = @"Card View";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserToBeShown:(UserProfile *)userToBeShown
{
    _userToBeShown = userToBeShown;
    
    NSLog(@"user to be shown is %@",userToBeShown.firstName);
}

@end
