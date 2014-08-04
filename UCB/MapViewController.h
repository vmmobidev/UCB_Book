//
//  MapViewController.h
//  UCB
//
//  Created by Vmoksha on 04/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController <MKMapViewDelegate>
{

}

@property (strong,nonatomic)Location *locationSelectedData;

@end
