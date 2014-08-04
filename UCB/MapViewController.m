//
//  MapViewController.m
//  UCB
//
//  Created by Vmoksha on 04/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"

#define METERS_PER_MILE 5000.344


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapViewOutLet;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *latLongString = self.locationSelectedData.latLong ;
    NSArray *latLongArr = [latLongString componentsSeparatedByString:@","];
    float latitude = [latLongArr[0] floatValue];
    float longitude = [latLongArr[1] floatValue];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    // 3
    [self.mapViewOutLet setRegion:viewRegion animated:YES];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
