//
//  DirectoryCell.h
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@protocol dirctoryCellDelegate <NSObject>

@optional
- (void)messageToUser:(UserProfile *)toUser;
@end

@interface DirectoryCell : UITableViewCell

@property (assign, nonatomic) BOOL displayMenu;
@property (assign, nonatomic) UserProfile *user;
@property (weak, nonatomic) id<dirctoryCellDelegate> delegateOfCell;

@end
