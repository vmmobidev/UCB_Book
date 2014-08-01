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

@end
