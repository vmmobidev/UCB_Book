//
//  ViewController.m
//  UCB
//
//  Created by Varghese Simon on 7/30/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageHeightConst;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
//        self.backgroundView.image = [UIImage imageNamed:@"UCB-Raw-Image-480h.png"];
        self.backgroundImageHeightConst.constant = 480;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
