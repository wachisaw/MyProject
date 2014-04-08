//
//  SampleSolvebyUIViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/5/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "SampleSolvebyUIViewController.h"

@interface SampleSolvebyUIViewController ()
- (IBAction)signonBtn:(id)sender;
- (IBAction)selectMenuBtn:(id)sender;
- (IBAction)getPOListBtn:(id)sender;
- (IBAction)selectPO1LvBtn:(id)sender;
- (IBAction)selectPO2LvBtn:(id)sender;
- (IBAction)approveBtm:(id)sender;
- (IBAction)rejectBtn:(id)sender;
- (IBAction)selectApprovalBtn:(id)sender;

@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;
@property (strong)EWIJsonConnector *connector3;
@property (strong)EWIJsonConnector *connector4;
@property (strong)EWIJsonConnector *connector5;
@property (strong)EWIJsonConnector *connector6;
@property (strong)EWIJsonConnector *connector7;
@property (strong)EWIJsonConnector *connector8;
@property (strong)EWIJsonConnector *connector9;
@property (strong)EWIJsonConnector *connector10;

@property (strong) NSString *ewiServer;
@property (strong) NSString *usr;
@property (strong) NSString *token;

-(void) clearLog;

@end

@implementation SampleSolvebyUIViewController

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
    
    self.ewiServer = @"http://172.16.26.111/apppo/jsonservice/";
    self.usr = @"WACHISAW";
    self.token = @"123";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)signonBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:@"WACHISAW" forKey:@"password"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"signonapprovepo_getmenulist";
    
    [self.connector requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);

}

- (IBAction)selectMenuBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    
    if (self.connector2 == nil) {
        self.connector2 = [EWIJsonConnector connector];
        self.connector2.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step100selectmenu";
    
    [self.connector2 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);

}

- (IBAction)getPOListBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [[NSMutableDictionary dictionary] init];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    
    if (self.connector3 == nil) {
        self.connector3 = [EWIJsonConnector connector];
        self.connector3.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step150getdoclist";
    
    [self.connector3 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);

}

- (IBAction)selectPO1LvBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [[NSMutableDictionary dictionary] init];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    [reqData setObject:@"13 00020649" forKey:@"docNo"];
    
    if (self.connector10 == nil) {
        self.connector10 = [EWIJsonConnector connector];
        self.connector10.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step200selectdoc";
    
    [self.connector10 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);
}

- (IBAction)selectPO2LvBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [[NSMutableDictionary dictionary] init];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    [reqData setObject:@"13 00020655" forKey:@"docNo"];
    
    if (self.connector4 == nil) {
        self.connector4 = [EWIJsonConnector connector];
        self.connector4.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step200selectdoc";
    
    [self.connector4 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);
}

- (IBAction)approveBtm:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    
    if (self.connector5 == nil) {
        self.connector5 = [EWIJsonConnector connector];
        self.connector5.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step300_150approve";
    
    [self.connector5 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);
    
}

- (IBAction)rejectBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    [reqData setObject:@"I WANT TO REject." forKey:@"reason"];
    
    if (self.connector7 == nil) {
        self.connector7 = [EWIJsonConnector connector];
        self.connector7.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step300_100reject";
    
    [self.connector7 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);
}

- (IBAction)selectApprovalBtn:(id)sender {
    [self clearLog];
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:self.usr forKey:@"username"];
    [reqData setObject:self.token forKey:@"ewitoken"];
    [reqData setObject:@"WACHISAW" forKey:@"approverSelect"];
    
    if (self.connector6 == nil) {
        self.connector6 = [EWIJsonConnector connector];
        self.connector6.delegate = self;
    }
    
    NSString *serviceName = [[NSString alloc] init];
    
    serviceName = @"approvepo_step400selectapproval";
    
    [self.connector6 requestEWIService:[self.ewiServer stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[self.ewiServer stringByAppendingString:serviceName]);
}



- (void) clearLog {
    NSLog(@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
}


- (void)requestEWIServiceStart:(EWIJsonConnector*)connector{
    //NSLog(@"requestEWIServiceStart %@", connector);
}


- (void)requestEWIServiceDone:(EWIJsonConnector*)connector responseData:(NSDictionary*)responseData{
    NSLog(@"Success");
    NSLog(@"requestEWIServiceDone %@", responseData);
    
    NSString *Returncode = [responseData objectForKey:@"Returncode"];
    NSString *Runmessage = [responseData objectForKey:@"Runmessage"];
    
    if ([Returncode isEqualToString:@"EWI-0000I"]) {
        
        if (connector==self.connector) {
            
            //NSDictionary *content = [responseData objectForKey:@"content"];
            //if (content) {
                //NSArray *listMenu = [content objectForKey:@"listMenu_appPOCollection"];
            //}
            
        } else if (connector==self.connector2) {
            
        }
        
        //[self performSegueWithIdentifier:@"MainMenuSegue" sender:self];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert windows" message:Runmessage delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)requestEWIServiceFail:(EWIJsonConnector*)connector {
    NSLog(@"Fail");
   NSLog(@"requestEWIServiceFail %@", connector);
}

@end
