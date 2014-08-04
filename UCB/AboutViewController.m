//
//  AboutViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
{
    UIBarButtonItem *revealButtonItem;
}

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
    revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationDrawerBtn];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
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
