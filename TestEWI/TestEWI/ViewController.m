//
//  ViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//by copy
@property (strong)EWIJsonConnector *connector;

//by manual
@property (assign) BOOL signedon;

//by drag
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)singon:(id)sender;
-(void) fortest1;


@end




@implementation ViewController

// by manual
static NSString *token = @"1234";
static id instance;

//------------------------------------------------------------------------------------------------------------------------------
//system define method
//------------------------------------------------------------------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    instance = self;
}

- (void)viewDidAppear:(BOOL)animated {
    self.signedon = NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.signedon;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"prepareForSegue");
}

//------------------------------------------------------------------------------------------------------------------------------
//interactive method
//------------------------------------------------------------------------------------------------------------------------------

- (IBAction)singon:(id)sender {
    [self logonAccess];
}

//------------------------------------------------------------------------------------------------------------------------------
//manual method
//------------------------------------------------------------------------------------------------------------------------------
+ (id)shareobject {
    return instance;
}

- (NSString *)getUserName {
    return self.userName.text;
}

- (NSString *)getPassword {
    return self.password.text;
}

- (NSString *)getToken {
    return token;
}

- (void) logonAccess {
    
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.userName.text forKey:@"username"];
    [reqData setObject:self.password.text forKey:@"password"];
    [reqData setObject:token forKey:@"ewitoken"];
    self.password.text = @"";
    
    
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    
    //[self.connector requestEWIService:@"http://172.16.26.111/ApprovePO/jsonservice/signonapppo" requestData:reqData];
    [self fortest1];
    
}

-(void) fortest1 {
    self.signedon = YES;
    [self performSegueWithIdentifier:@"MainMenuSegue" sender:self];
}

- (void) closeMe {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) clearPassword {
    self.password.text = @"";
}



//------------------------------------------------------------------------------------------------------------------------------
//code below use in the future
//------------------------------------------------------------------------------------------------------------------------------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//------------------------------------------------------------------------------------------------------------------------------
//delegate from AS400 service 3 methods below
//------------------------------------------------------------------------------------------------------------------------------

- (void)requestEWIServiceStart:(EWIJsonConnector*)connector{
    NSLog(@"requestEWIServiceStart %@", connector);
}

- (void)requestEWIServiceDone:(EWIJsonConnector*)connector responseData:(NSDictionary*)responseData{
    NSLog(@"requestEWIServiceDone %@", responseData);
    
    NSString *Returncode = [responseData objectForKey:@"Returncode"];
    NSString *Runmessage = [responseData objectForKey:@"Runmessage"];
    
    if ([Returncode isEqualToString:@"EWI-0000I"]) {
        
        self.signedon = YES;
        
        [self performSegueWithIdentifier:@"MainMenuSegue" sender:self];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert windows" message:Runmessage delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)requestEWIServiceFail:(EWIJsonConnector*)connector{
    NSLog(@"requestEWIServiceFail %@", connector);
}


@end
