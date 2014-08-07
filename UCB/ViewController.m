//
//  ViewController.m
//  UCB
//
//  Created by Varghese Simon on 7/30/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "PLView.h"
#import "PLJSONLoader.h"

@interface ViewController () <UIScrollViewDelegate, signInDelegate, PLViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet PLView *plView;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
//        self.backgroundView.image = [UIImage imageNamed:@"UCB-Raw-Image-480h.png"];
    }
    
    self.logInButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.logInButton.layer.borderWidth = 0.5f;
    self.logInButton.layer.cornerRadius = 8.0f;
    
    self.navigationController.navigationBarHidden = YES;
    
    self.plView.delegate = self;
	self.plView.isAccelerometerEnabled = YES;
	self.plView.isScrollingEnabled = YES;
	self.plView.isInertiaEnabled = YES;
    
    NSObject<PLIPanorama> *panorama = nil;
    panorama = [PLSphericalPanorama panorama];
    [(PLSphericalPanorama *)panorama setTexture:[PLTexture textureWithImage:[PLImage imageWithPath:[[NSBundle mainBundle] pathForResource:@"UCB-Raw-Image" ofType:@"png"]]]];
    
    [self.plView setPanorama:panorama];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLogInPage:(UIButton *)sender
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SignInViewController class]])
    {
        SignInViewController *sigInVC = (SignInViewController *)segue.destinationViewController;
        sigInVC.delegate = self;
    }
}

- (void)loginSucessfull
{
    [self performSegueWithIdentifier:@"revealVCSegue" sender:self];
}

- (BOOL)view:(UIView<PLIView> *)pView shouldBeginInertia:(CGPoint)starPoint endPoint:(CGPoint)endPoint
{
    return YES;
}

-(BOOL)view:(UIView<PLIView> *)pView shouldRunInertia:(CGPoint)starPoint endPoint:(CGPoint)endPoint
{
    return YES;
}

@end
