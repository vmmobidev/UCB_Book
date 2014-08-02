//
//  DirectryViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "DirectryViewController.h"
#import "DirectoryCell.h"
#import "Postman.h"
#import "WholeEmployeeDetails.h"
#import <MessageUI/MessageUI.h>
#import "SWRevealViewController/SWRevealViewController.h"

@interface DirectryViewController () <UITableViewDataSource, UITableViewDelegate, postmanDelegate, dirctoryCellDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DirectryViewController
{
    UIBarButtonItem *revealButtonItem;
    NSMutableArray *selectedCells;
    NSArray *arrayOfAllEmployees;
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
    revealButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationDrawerBtn];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    Postman *postman = [[Postman alloc] init];
    postman.delegate = self;
    
    [postman get:@"http://vzoneapps.ripple-io.in/Employees"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfAllEmployees count];
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
    
    cell.user = arrayOfAllEmployees[indexPath.row];
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


#pragma mark - Postman delegate
- (void)postman:(Postman *)postman gotFailure:(NSError *)error
{
    NSLog(@"Failure");
}

- (void)postman:(Postman *)postman gotSuccess:(NSData *)response
{
    NSLog(@"Sucess");
    WholeEmployeeDetails *wholeEmployeesList = [[WholeEmployeeDetails alloc] init];
    arrayOfAllEmployees = [wholeEmployeesList firstTwoLevelOfEmployeesForData:response];
    
    [self.tableView reloadData];
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
