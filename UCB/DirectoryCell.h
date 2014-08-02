//
//  DirectoryCell.h
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface DirectoryCell : UITableViewCell

@property (assign, nonatomic) BOOL displayMenu;
@property (assign, nonatomic) UserProfile *user;

@end
