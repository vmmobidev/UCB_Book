//
//  CardViewCell.m
//  UCB
//
//  Created by Varghese Simon on 8/2/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "CardViewCell.h"

@interface CardViewCell ()

@property (weak, nonatomic) IBOutlet UIView *roundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CardViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)initialize
{

}

- (void)setUser:(UserProfile *)user
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@ %@", user.firstName, user.middleName, user.lastName];
    self.roundView.layer.cornerRadius = 30;
    self.roundView.layer.borderColor = [UIColor redColor].CGColor;
    self.roundView.layer.borderWidth = 1;
    self.roundView.layer.masksToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
