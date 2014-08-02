//
//  SignInViewController.m
//  UCB
//
//  Created by Varghese Simon on 8/1/14.
//  Copyright (c) 2014 Vmoksha. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtFld;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorOutlet;
@property (weak, nonatomic) IBOutlet UIView *alphaView;
@property (weak, nonatomic) IBOutlet UILabel *authenticationFailLable;

@end

@implementation SignInViewController

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
    self.userNameTxtFld.text = @"surajm@vmokshagroup.com";
    self.passwordTxtFld.text = @"Power@1234";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisskeyBoard)];
    [self.view addGestureRecognizer:tap];

    
}
-(void)dismisskeyBoard
{
    [self.view endEditing:YES];
}

- (IBAction)signInBtnAction:(id)sender {
    
    [self.view endEditing:YES];

    NSString *parameterString = [NSString stringWithFormat:@"{\"request\":{\"Username\":\"%@\",\"Password\":\"%@\"}}",self.userNameTxtFld.text,self.passwordTxtFld.text];
    
    Postman *postman = [[Postman alloc] init];
    postman.delegate = self;
    [postman  post:@"http://vzoneapps.ripple-io.in/Account/Authenticate" withParameters:parameterString];
    
    [UIView animateWithDuration:.3 animations:^{
        self.alphaView.alpha = .4;
    } completion:^(BOOL finished) {
        [self.activityIndicatorOutlet startAnimating];
        self.alphaView.hidden = NO;
        
    }];
}

#pragma mark UITextFieldDelegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
{
    [UIView animateWithDuration:.3 animations:^{
        self.authenticationFailLable.alpha = 0;
    } completion:^(BOOL finished) {
        self.authenticationFailLable.hidden = YES;
        
    }];    return YES;
}


#pragma mark postmanDelegate methods

-(void)postman:(Postman *)postman gotSuccess:(NSData *)response
{
    
    [UIView animateWithDuration:.5 animations:^{
        self.alphaView.alpha = 0;
    } completion:^(BOOL finished) {
        self.alphaView.hidden = YES;

        
    }];
    //    NSString *string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //    NSLog(@"====== %@",string);
    
    NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:Nil];
    NSDictionary *aaDataDict = JSONResponse[@"aaData"];
    
    if ([aaDataDict[@"Success"] boolValue])
    {
        


        [self.activityIndicatorOutlet stopAnimating];

        NSLog(@"Authentication successful");
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(loginSucessfull)])
            {
                [self.delegate loginSucessfull];
            }
        }];
        
    }else
    {
        NSLog(@"Authentication failed");
        [UIView animateWithDuration:.5 animations:^{
            self.authenticationFailLable.alpha = 1;
            self.authenticationFailLable.hidden = NO;

        } completion:^(BOOL finished) {
            [self.activityIndicatorOutlet stopAnimating];
            
        }];
    }
}

-(void)postman:(Postman *)postman gotFailure:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

