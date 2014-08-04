//
//  CardViewController.m
//  UCB
//
//  Created by Vmoksha on 01/08/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "CardViewController.h"
#import "WholeEmployeeDetails.h"
#import "CardViewCell.h"
#import <MessageUI/MessageUI.h>
#import "SlideOutMenuViewController.h"

@interface CardViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *reportsToCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *directReporteesCollectionView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *nameOfUser;
@property (weak, nonatomic) IBOutlet UILabel *designationLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewTopConst;
@end

@implementation CardViewController
{
    NSArray *directReportees;
    NSArray *userToReportArray;
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
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationDrawerBtn];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.title = @"Card View";

//    directReportees = [[WholeEmployeeDetails sharedInstance] directReporteesFor:self.userToBeShown InListOfEmployee:nil];
//    
//    if (self.userToBeShown.reportsTo != 0)
//    {
//        UserProfile *userToReports = [[WholeEmployeeDetails sharedInstance] userForID:self.userToBeShown.reportsTo];
//        userToReportArray = @[userToReports];
//    }
    
    if (self.userToBeShown == nil)
    {
        self.userToBeShown = [[WholeEmployeeDetails sharedInstance] userForID:10];
    }
    
    [self updateViewForUser:self.userToBeShown];
    
    SlideOutMenuViewController *slideVC = (SlideOutMenuViewController *) self.revealViewController.rearViewController;
    slideVC.currentFrontVCIndex = 1;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateViewForChanges];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.reportsToCollectionView])
    {
        return [userToReportArray count];
        
    }else if([collectionView isEqual:self.directReporteesCollectionView])
    {
        return [directReportees count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardViewCell" forIndexPath:indexPath];
    if ([collectionView isEqual:self.reportsToCollectionView])
    {
        cell.user = userToReportArray[indexPath.row];
        
    }else if ([collectionView isEqual:self.directReporteesCollectionView])
    {
        cell.user = directReportees[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserProfile *selectedUser;
    if ([collectionView isEqual:self.directReporteesCollectionView])
    {
        selectedUser = directReportees[indexPath.item];
        
    }else if ([collectionView isEqual:self.reportsToCollectionView])
    {
        selectedUser = userToReportArray[indexPath.item];
    }
    
    self.userToBeShown = selectedUser;
    
    [self updateViewForUser:selectedUser];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserToBeShown:(UserProfile *)userToBeShown
{
    _userToBeShown = userToBeShown;
    NSLog(@"user to be shown is %@",userToBeShown.firstName);
}

- (void)updateViewForChanges
{
    if ([userToReportArray count] == 0)
    {
        [self.topView removeFromSuperview];
        self.middleViewTopConst.constant = 0;
    }else
    {
        if (self.topView.superview == nil)
        {
            [self.view addSubview:self.topView];
            self.middleViewTopConst.constant = 114;
        }
    }
    
    [UIView animateWithDuration:.3
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)updateViewForUser:(UserProfile *)toUser
{
    directReportees = [[WholeEmployeeDetails sharedInstance] directReporteesFor:toUser InListOfEmployee:nil];
    
    if (toUser.reportsTo != 0)
    {
        UserProfile *userToReports = [[WholeEmployeeDetails sharedInstance] userForID:toUser.reportsTo];
        userToReportArray = @[userToReports];
    }else
    {
        userToReportArray = nil;
    }
    
    self.nameOfUser.text = [NSString stringWithFormat:@"%@ %@ %@", self.userToBeShown.firstName,self.userToBeShown.middleName, self.userToBeShown.lastName];
    self.designationLabel.text = self.userToBeShown.designation;
    
    [self.directReporteesCollectionView reloadData];
    [self.reportsToCollectionView reloadData];
    [self updateViewForChanges];
}
- (IBAction)messageTo:(UIButton *)sender
{
    if (self.userToBeShown.mobileNo == nil)
    {
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText])
    {
        messageController.body = @"";
		messageController.recipients = [NSArray arrayWithObjects:self.userToBeShown.mobileNo, nil];
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
    mailComposer.toRecipients = @[self.userToBeShown.emailID];
    [mailComposer setSubject:@""];
    [mailComposer setMessageBody:@"" isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (IBAction)phoneTo:(UIButton *)sender
{
    if (self.userToBeShown.mobileNo )
    {
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.userToBeShown.mobileNo];
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
