//
//  LocationViewController.m
//  UCB
//
//  Created by Vmoksha on 02/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "LocationViewController.h"
#import "Location.h"

@interface LocationViewController ()

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ubc_location" ofType:@"js"];
    
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    
    NSArray *locationDataArr = jsonData[@"ucblocation"];
    Location *locat = [[Location alloc] init];
    
    for (NSDictionary *anlocation in locationDataArr) {
        locat.country = anlocation [@"country"];
        NSLog(@"%@",locat.country);
    }
    
    
    
 

    
    
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
