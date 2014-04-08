//
//  ApprovalViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "ApprovalViewController.h"
#import "ApprovalCell.h"
#import "AccessViewController.h"
#import "HeaderViewController.h"
#import "DetailViewController.h"
#import "HDDTTableViewController.h"

@interface ApprovalViewController ()
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;
@property (strong) NSString *selectedApproval;
- (IBAction)backBtn:(id)sender;
-(void) setArray;
-(void) requestBack;
-(void) requestSelectApproval;

@end

@implementation ApprovalViewController

@synthesize newsArray;
@synthesize newsArray2;
@synthesize newsArray3;
@synthesize tableView;

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
	
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
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
        [self setArray];
    } else {
        self.dictionary = [mainClass getDictionaryDetail];
        NSDictionary *content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.docNo.text = [content objectForKey:@"poNo"];
        }
        self.dictionary = [mainClass getDictionaryApproval];
        content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.data = [content objectForKey:@"approverListCollection"];
            [self.tableView reloadData];
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.canGo = NO;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.canGo;
}

-(void) setArray {
    self.newsArray = [[NSArray alloc] initWithObjects:@"1. APPPO1",@"2. APPPO2", nil];
    self.newsArray2 = [[NSArray alloc] initWithObjects:@"2,000,000.00",@"3,000,000.00", nil];
    self.newsArray3 = [[NSArray alloc] initWithObjects:@"2",@"2", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    if ([mainClass getIsTest]) {
        //[detailClass stWillCloseNextAppear:@"Y"];
        //[headerClass stWillCloseNextAppear:@"Y"];
        [hDDTClass stWillCloseNextAppear:@"Y"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self requestBack];
    }
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
    serviceName = @"approvepo_step930exitapvl";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([mainClass getIsTest]) {
        if (self.newsArray!=nil) {
            return [self.newsArray count];
        }
    } else {
        if (self.data!=nil) {
            return [self.data count];
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    ApprovalCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        [cell setApproval:[self.newsArray objectAtIndex:row] amount:[self.newsArray2 objectAtIndex:row] level:[self.newsArray3 objectAtIndex:row]];
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"approverList"];
            NSString *amount = [listFields objectForKey:@"amount"];
            NSString *approver = [listFields objectForKey:@"approver"];
            //NSString *dds = [listFields objectForKey:@"dds"];
            NSString *level = [listFields objectForKey:@"level"];
            [cell setApproval:approver amount:amount level:level];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        //self.canGo = YES;
        //[self performSegueWithIdentifier:@"HeaderSegue" sender:self];
        NSString *approver = [newsArray objectAtIndex:row];
        NSLog(@"%@",approver);
        [mainClass alert:@"Approve completed."];
        //[detailClass stWillCloseNextAppear:@"Y"];
        //[headerClass stWillCloseNextAppear:@"Y"];
        [hDDTClass stWillCloseNextAppear:@"Y"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"approverList"];
            self.selectedApproval = [listFields objectForKey:@"approver"];
            [self requestSelectApproval];
        }
    }
}

- (void) requestSelectApproval {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    [reqData setObject:self.selectedApproval forKey:@"approverSelect"];
    if (self.connector2 == nil) {
        self.connector2 = [EWIJsonConnector connector];
        self.connector2.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step400selectapproval";
    [self.connector2 requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
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
        } else if (connector==self.connector2) {
            [mainClass alert:@"Approve completed."];
            //[detailClass stWillCloseNextAppear:@"Y"];
            //[headerClass stWillCloseNextAppear:@"Y"];
            [hDDTClass stWillCloseNextAppear:@"Y"];
            [self dismissViewControllerAnimated:YES completion:nil];
            /*[mainClass stDictionaryDetail:responseData];
            self.canGo = YES;
            [self performSegueWithIdentifier:@"HeaderSegue" sender:self];*/
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
