//
//  AboutViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "AboutViewController.h"


@interface AboutViewController () <SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webViewOutlet;

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
    
    
    self.revealViewController.delegate = self;
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
}

- (void) viewWillAppear:(BOOL)animated
{
	//Load the index.html file.
	NSBundle* bundle     = [NSBundle mainBundle];
	NSString* filePath   = [bundle pathForResource:@"aboutUs" ofType:@"html"];
	[self.webViewOutlet loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if (position == FrontViewPositionRight)
    {
        [self.view endEditing:YES];
        UIView *disableViewForSW = [[UIView alloc] initWithFrame:self.view.bounds];
        disableViewForSW.backgroundColor = [UIColor clearColor];
        disableViewForSW.tag = 1010;
        [self.view addSubview:disableViewForSW];
    }else if (position == FrontViewPositionLeft)
    {
        UIView *disableViewForSW = [self.view viewWithTag:1010];
        [disableViewForSW removeFromSuperview];
    }
}

-(BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request
navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = request.URL;
	if ((![[url absoluteString] isEqualToString:@"about:blank"]) &&
	    (![[url scheme        ] isEqualToString:@"file"       ]) )
	{
		[[UIApplication sharedApplication] openURL:url];
		return false;
	}
	return true;
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
