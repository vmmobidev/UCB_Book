//
//  ViewController.m
//  UCB
//
//  Created by Varghese Simon on 7/30/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"

@interface ViewController () <UIScrollViewDelegate, signInDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundImageHeightConst;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController
{
    NSTimer *movementTimer;
    NSInteger currentPageNo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([UIScreen mainScreen].bounds.size.height != 568)
    {
//        self.backgroundView.image = [UIImage imageNamed:@"UCB-Raw-Image-480h.png"];
        self.backgroundImageHeightConst.constant = 480;
    }
    
    self.logInButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.logInButton.layer.borderWidth = 0.5f;
    self.logInButton.layer.cornerRadius = 8.0f;
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    movementTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                                     target:self
                                                   selector:@selector(timerIsFired:)
                                                   userInfo:nil
                                                    repeats:YES];
    
    currentPageNo = 2;
    [self setScrollView:self.scrollView toPageNo:currentPageNo animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [movementTimer invalidate];
    movementTimer = nil;
}

- (void)timerIsFired:(NSTimer *)firedTimer
{
    if (currentPageNo != 3)
    {
        currentPageNo++;
        [self setScrollView:self.scrollView toPageNo:currentPageNo animated:YES];
    }else
    {
        currentPageNo = 0;
        [self setScrollView:self.scrollView toPageNo:currentPageNo animated:YES];
    }
}

- (void)setScrollView:(UIScrollView *)scrollView toPageNo:(NSInteger)toPageNo animated:(BOOL)animated
{
    CGPoint nextContentOffset = CGPointMake(toPageNo*320, 0);
    [scrollView setContentOffset:nextContentOffset animated:animated];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    currentPageNo = [scrollView contentOffset].x / 320;
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

@end
