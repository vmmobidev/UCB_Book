//
//  DetailsViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "DetailsViewController.h"
#import "WholeEmployeeDetails.h"
#import "DirectReporteesViewController.h"
#import <MessageUI/MessageUI.h>

@interface DetailsViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameOfUser;
@property (weak, nonatomic) IBOutlet UILabel *designationLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *noOfReporteesLabel;

@end

@implementation DetailsViewController
{
    NSArray *directReportees;
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
    
    directReportees = [[WholeEmployeeDetails sharedInstance] directReporteesFor:self.user InListOfEmployee:nil];
    NSLog(@"Direct Reportees count = %i", [directReportees count]);
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.user != nil)
    {
        self.nameOfUser.text = [NSString stringWithFormat:@"%@ %@ %@", self.user.firstName, self.user.middleName, self.user.lastName];
        self.designationLabel.text = self.user.designation;
        self.emailIDLabel.text = self.user.emailID;
        self.mobileNoLabel.text = self.user.mobileNo;
        self.noOfReporteesLabel.text = [NSString stringWithFormat:@"%i",[directReportees count]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailsVCToDirectRVCSegue"])
    {
        DirectReporteesViewController *directVC = (DirectReporteesViewController *)segue.destinationViewController;
        directVC.listOfDirectReportees = directReportees;
    }
}

- (IBAction)viewListOfDirectRs:(UIButton *)sender
{
    if ([directReportees count] > 0)
    {
        [self performSegueWithIdentifier:@"detailsVCToDirectRVCSegue" sender:self];
    }
}

- (IBAction)messageTo:(UIButton *)sender
{
    if (self.user.mobileNo == nil)
    {
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText])
    {
        messageController.body = @"";
		messageController.recipients = [NSArray arrayWithObjects:self.user.mobileNo, nil];
		messageController.messageComposeDelegate = self;
        [self presentViewController:messageController
                           animated:YES
                         completion:^{
                             
                         }];
    }
}
- (IBAction)emailTo:(UIButton *)sender
{
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.toRecipients = @[self.user.emailID];
    [mailComposer setSubject:@""];
    [mailComposer setMessageBody:@"" isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (IBAction)phoneTo:(UIButton *)sender
{
    if (self.user.mobileNo )
    {
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.user.mobileNo];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    UIAlertView *alert;
    switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			alert = [[UIAlertView alloc] initWithTitle:@"MyApp"
                                               message:@"Unknown Error"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
			[alert show];
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *alert;
    switch (result) {
		case MFMailComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MFMailComposeResultFailed:
			alert = [[UIAlertView alloc] initWithTitle:@"MyApp"
                                               message:@"Unknown Error"
                                              delegate:self
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles: nil];
			[alert show];
			break;
		case MFMailComposeResultSent:
            
			break;
		default:
			break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
