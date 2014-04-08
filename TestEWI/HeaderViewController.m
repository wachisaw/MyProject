//
//  HeaderViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "HeaderViewController.h"
#import "AccessViewController.h"

@interface HeaderViewController ()
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
- (IBAction)backBtn:(id)sender;
- (IBAction)nextBtn:(id)sender;
-(void)setHeader;
- (void) requestBack;

@end

@implementation HeaderViewController

static id instance;
static id mainClass;

+ (id)shareobject {
    return instance;
}

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
	
    instance = self;
    
    self.willCloseNextAppear = @"N";

    AccessViewController *ac = [AccessViewController shareobject];
    mainClass = ac;
    
    [self setHeader];
}
-(void)setHeader {
    if ([mainClass getIsTest]) {
        self.docNo.text = @"PO No 1300020612";
        self.docDate.text = @"29/10/2013";
        self.requester.text = @"003129 835";
        self.description1.text = @"Buy computer desktop";
        self.vendorName.text = @"00555 CP SEVEN ELEVEN";
        self.amount.text = @"203,500.00";
        self.vatAmount.text = @"14,245.00";
        self.totalAmount.text = @"217,745.00";
        self.overseaAmount.text = @"0.00";
    } else {
        self.dictionary = [mainClass getDictionaryDetail];
        NSDictionary *content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.docNo.text = [content objectForKey:@"poNo"];
            self.docDate.text = [content objectForKey:@"poDate"];
            self.requester.text = [content objectForKey:@"requester"];
            self.description1.text =[content objectForKey:@"descript"];
            self.vendorName.text = [content objectForKey:@"vendor"];
            self.amount.text = [content objectForKey:@"poAmount"];
            self.vatAmount.text = [content objectForKey:@"vatAmount"];
            self.totalAmount.text = [content objectForKey:@"totalAmount"];
            self.overseaAmount.text = [content objectForKey:@"overSea"];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    if ([mainClass getIsTest]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self requestBack];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    self.canGo = NO;
    if ([self.willCloseNextAppear isEqualToString:@"Y"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.canGo;
}

- (void) stWillCloseNextAppear:(NSString *)willCloseNextAppear {
    self.willCloseNextAppear = willCloseNextAppear;
}

- (void) requestBack {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step920exitdt";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}


- (IBAction)nextBtn:(id)sender {
    self.canGo = YES;
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
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
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [mainClass alert:Runmessage];
    }
}

- (void)requestEWIServiceFail:(EWIJsonConnector*)connector{
    //NSLog(@"requestEWIServiceFail %@", connector);
    [mainClass alert:@"Can not connect to EWI service server."];
}
@end
