//
//  SignInViewController.h
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Postman.h"

@class SignInViewController;
@protocol signInDelegate <NSObject>

-(void)loginSucessfull;

@end

@interface SignInViewController : UIViewController < UITextFieldDelegate,postmanDelegate>

@property (weak, nonatomic) id <signInDelegate>delegate;

@end
