//
//  ReasonViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/6/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "ReasonViewController.h"
#import "AccessViewController.h"
#import "HeaderViewController.h"
#import "DetailViewController.h"
#import "HDDTTableViewController.h"

@interface ReasonViewController ()
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
- (IBAction)backBtn:(id)sender;
- (IBAction)rejectBtn:(id)sender;
-(void) requestReason;

@end

@implementation ReasonViewController

static id mainClass;
static id headerClass;
static id detailClass;
static id hDDTClass;


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
    
	AccessViewController *ac = [AccessViewController shareobject];
    mainClass = ac;
    HeaderViewController *hc = [HeaderViewController shareobject];
    headerClass = hc;
    DetailViewController *dc = [DetailViewController shareobject];
    detailClass = dc;
    HDDTTableViewController *hdc = [HDDTTableViewController shareobject];
    hDDTClass = hdc;
    
    if ([mainClass getIsTest]) {
        self.docNo.text = @"PO No 1300020612";
    } else {
        self.dictionary = [mainClass getDictionaryDetail];
        NSDictionary *content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.docNo.text = [content objectForKey:@"poNo"];
        }
    }

}

- (void)viewDidAppear:(BOOL)animated{
    self.canGo = NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.canGo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rejectBtn:(id)sender {
    BOOL errFound = NO;
    if (errFound == NO && [self.reason.text isEqualToString:@""]) {
        [mainClass alert:@"Reject can not be blank."];
        errFound = YES;
    }
    if (errFound == NO) {
        if ([mainClass getIsTest]) {
            [mainClass alert:@"Reject completed.(test)"];
            //[detailClass stWillCloseNextAppear:@"Y"];
            //[headerClass stWillCloseNextAppear:@"Y"];
            [hDDTClass stWillCloseNextAppear:@"Y"];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self requestReason];
        }
    }
}

-(void) requestReason {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    [reqData setObject:self.reason.text forKey:@"reason"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step300_100reject";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
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
            [mainClass alert:@"Reject completed."];
            //[detailClass stWillCloseNextAppear:@"Y"];
            //[headerClass stWillCloseNextAppear:@"Y"];
            [hDDTClass stWillCloseNextAppear:@"Y"];
            [self dismissViewControllerAnimated:YES completion:nil];
            /*[mainClass stDictionaryDoc:responseData];
             self.dictionary = [mainClass getDictionaryDoc];
             NSDictionary *content = [self.dictionary objectForKey:@"content"];
             if (content) {
             self.data = [content objectForKey:@"datalistPOCollection"];
             [self.tableView reloadData];
             }*/
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
