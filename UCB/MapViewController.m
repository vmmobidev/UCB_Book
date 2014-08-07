//
//  MapViewController.m
//  UCB
//
//  Created by Vmoksha on 04/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"
#import "MapDetailsViewController.h"

#define METERS_PER_MILE 3000.344


@interface MapViewController ()
{
    CLLocationCoordinate2D zoomLocation;

}
@property (weak, nonatomic) IBOutlet MKMapView *mapViewOutLet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapModeSelector;

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
    
    self.title = self.locationSelectedData.country;
    NSString *latLongString = self.locationSelectedData.latLong ;
    NSArray *latLongArr = [latLongString componentsSeparatedByString:@","];
    float latitude = [latLongArr[0] floatValue];
    float longitude = [latLongArr[1] floatValue];
    
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
        [self.mapViewOutLet setRegion:viewRegion animated:YES];

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = zoomLocation;
    annotation.title = self.locationSelectedData.companyName;
    [self.mapViewOutLet addAnnotation:annotation];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.mapViewOutLet.delegate = self;

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation

{
    static NSString *identifier = @"Pin";
    MKAnnotationView *annotationView = (MKAnnotationView *)[_mapViewOutLet dequeueReusableAnnotationViewWithIdentifier:identifier];
    annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
    annotationView.enabled = YES;
    annotationView.canShowCallout =YES;
    annotationView.image = [UIImage imageNamed:@"ucb-location-icon.png"];
    annotationView.frame = CGRectMake(0, 0, 45,50);
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"mapDetails_seque" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapDetailsViewController *mapDetails = segue.destinationViewController;
    mapDetails.detailsOfMap = self.locationSelectedData;
    
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
- (IBAction)changeMapType:(UISegmentedControl *)sender
{
    self.mapViewOutLet.mapType = sender.selectedSegmentIndex;
}

@end
