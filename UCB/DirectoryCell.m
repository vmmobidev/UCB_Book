//
//  DirectoryCell.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "DirectoryCell.h"

@interface DirectoryCell ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *employeePosition;
@property (weak, nonatomic) IBOutlet UIView *menuView;

@end

@implementation DirectoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initialize];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self initialize];
}

- (void)initialize
{
    self.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDisplayMenu:(BOOL)displayMenu
{
    _displayMenu = displayMenu;
    
    if (displayMenu)
    {
        [self unhideMenu];
    }else
    {
        [self hideMenu];
    }
}

- (void)unhideMenu
{
    self.menuView.hidden = NO;
}

- (void)hideMenu
{
    self.menuView.hidden = YES;
}

- (void)setUser:(UserProfile *)user
{
    _user = user;
    self.userName.text = [NSString stringWithFormat:@"%@ %@",user.firstName, user.lastName];
    self.employeePosition.text = user.designation;
}
- (IBAction)phoneUser:(UIButton *)sender
{
    if (!self.user.mobileNo )
    {
        NSString *phoneNumber = [@"telprompt://" stringByAppendingString:self.user.mobileNo];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

- (IBAction)messageUser:(UIButton *)sender
{
    if ([self.delegateOfCell respondsToSelector:@selector(messageToUser:)])
    {
        [self.delegateOfCell messageToUser:self.user];
    }
//    
//    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//    
//    if ([MFMessageComposeViewController canSendText])
//    {
//        messageController.body = @"";
//		messageController.recipients = [NSArray arrayWithObjects:@"12345678", @"87654321", nil];
//		messageController.messageComposeDelegate = self;
////		[self presentModalViewController:messageController animated:YES];
//    }
}

- (IBAction)emailUser:(id)sender
{
    
}
- (IBAction)showDetailedView:(UIButton *)sender
{
    
}
- (IBAction)showCardView:(UIButton *)sender
{
    
}

@end
