//
//  DirectReporteesViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/4/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "DirectReporteesViewController.h"
#import <MessageUI/MessageUI.h>
#import "UserProfile.h"
#import "DirectoryCell.h"
#import "CardViewController.h"
#import "DetailsViewController.h"

@interface DirectReporteesViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, dirctoryCellDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation DirectReporteesViewController
{
    NSMutableArray *selectedCells;
    UserProfile *selectedUser;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UItableviewdelegate delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listOfDirectReportees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DirectoryCell *cell = (DirectoryCell *) [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ([selectedCells containsObject:indexPath])
    {
        cell.displayMenu = YES;
    }else
    {
        cell.displayMenu = NO;
    }
    
    cell.user = self.listOfDirectReportees[indexPath.row];
    NSLog(@"%i",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DirectoryCell *selectedCell = (DirectoryCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    if (!selectedCells)
    {
        selectedCells = [[NSMutableArray alloc] init];
    }
    
    if ([selectedCells containsObject:indexPath])
    {
        [selectedCells removeObject:indexPath];
        selectedCell.displayMenu = NO;
        selectedCell.delegateOfCell = nil;
    }else
    {
        [selectedCells addObject:indexPath];
        selectedCell.displayMenu = YES;
        selectedCell.delegateOfCell = self;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([selectedCells containsObject:indexPath])
    {
        return 82;
    }else
        return 48;
}

#pragma mark - DirectoryCell delegate
- (void)messageToUser:(UserProfile *)toUser
{
    if (toUser.mobileNo == nil)
    {
        return;
    }
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText])
    {
        messageController.body = @"";
		messageController.recipients = [NSArray arrayWithObjects:toUser.mobileNo, nil];
		messageController.messageComposeDelegate = self;
        [self presentViewController:messageController
                           animated:YES
                         completion:^{
                             
                         }];
    }
}

- (void)emailToUser:(UserProfile *)toUser
{
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    mailComposer.toRecipients = @[toUser.emailID];
    [mailComposer setSubject:@""];
    [mailComposer setMessageBody:@"" isHTML:NO];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void)showCardViewOfUser:(UserProfile *)ofUser
{
    selectedUser = ofUser;
    [self performSegueWithIdentifier:@"directRVCToCardVCSegue" sender:self];
}


- (void)showDetailsViewOfUser:(UserProfile *)ofUser
{
    selectedUser = ofUser;
    [self performSegueWithIdentifier:@"DirectRVCToDetailsVCSegue" sender:self];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"directRVCToCardVCSegue"])
    {
        CardViewController *carVC = (CardViewController *)segue.destinationViewController;
        carVC.userToBeShown = selectedUser;
        
    }else if ([segue.identifier isEqualToString:@"DirectRVCToDetailsVCSegue"])
    {
        DetailsViewController *detailsVC = (DetailsViewController *)segue.destinationViewController;
        detailsVC.user = selectedUser;
    }
}

@end
