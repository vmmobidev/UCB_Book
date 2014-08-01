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
}
- (IBAction)signInBtnAction:(id)sender {
    NSString *parameterString = [NSString stringWithFormat:@"{\"request\":{\"Username\":\"manoharas@vmokshagroup.com\",\"Password\":\"Power@1234\"}}"];
    
    Postman *postman = [[Postman alloc] init];
    postman.delegate = self;
    [postman  post:@"http://vzoneapps.ripple-io.in/Account/Authenticate" withParameters:parameterString];
}


#pragma mark postmanDelegate methods

-(void)postman:(Postman *)postman gotSuccess:(NSData *)response
{
    
    //    NSString *string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    //    NSLog(@"====== %@",string);
    
    NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:Nil];
    NSDictionary *aaDataDict = JSONResponse[@"aaData"];
    
    if ([aaDataDict[@"Success"] boolValue])
    {
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

