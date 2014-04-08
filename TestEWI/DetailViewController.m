//
//  DetailViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/2/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "AccessViewController.h"
#import "HeaderViewController.h"

@interface DetailViewController ()
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;
@property (strong)EWIJsonConnector *connector3;
- (IBAction)backBtn:(id)sender;
- (void) setArray;
- (void) requestApprove;
- (IBAction)rejectBtn:(id)sender;
- (IBAction)approveBtn:(id)sender;


@end

@implementation DetailViewController

@synthesize newsArray;
@synthesize newsArray2;
@synthesize newsArray3;
@synthesize newsArray4;
@synthesize newsArray5;
@synthesize tableView;

static id instance;
static id mainClass;
static id headerClass;

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
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    instance = self;
    
    self.willCloseNextAppear = @"N";
    
    AccessViewController *ac = [AccessViewController shareobject];
    mainClass = ac;
    HeaderViewController *hc = [HeaderViewController shareobject];
    headerClass = hc;
    
    if ([mainClass getIsTest]) {
        self.docNo.text = @"PO No 1300020612";
        [self setArray];
    } else {
        self.dictionary = [mainClass getDictionaryDetail];
        NSDictionary *content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.docNo.text = [content objectForKey:@"poNo"];
            self.data = [content objectForKey:@"detailItemListCollection"];
            [self.tableView reloadData];
        }
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

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rejectBtn:(id)sender {
    self.canGo = YES;
    [self performSegueWithIdentifier:@"ReasonSegue" sender:self];
}

- (IBAction)approveBtn:(id)sender {
    if ([mainClass getIsTest]) {
        self.canGo = YES;
        [self performSegueWithIdentifier:@"ApprovalSegue" sender:self];
    } else {
        [self requestApprove];
    }
    
}

- (void) requestApprove {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step300_150approve";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}


-(void) setArray {
    self.newsArray = [[NSArray alloc] initWithObjects:@"1. 014849DSD",@"2. 07FUSB", nil];
    self.newsArray2 = [[NSArray alloc] initWithObjects:@"MS Windows Server 2003",@"USB Flash Drive", nil];
    self.newsArray3 = [[NSArray alloc] initWithObjects:@"10.00",@"5.00", nil];
    self.newsArray4 = [[NSArray alloc] initWithObjects:@"20,000.00",@"3,500.00", nil];
    self.newsArray5 = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    DetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        [cell setProduct:[self.newsArray objectAtIndex:row] description:[self.newsArray2 objectAtIndex:row] qty:[self.newsArray3 objectAtIndex:row]  amount:[self.newsArray4 objectAtIndex:row] seq:[self.newsArray5 objectAtIndex:row]];
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"detailItemList"];
            NSString *product = [listFields objectForKey:@"product"];
            NSString *poAmount = [listFields objectForKey:@"poAmount"];
            NSString *descDetail = [listFields objectForKey:@"descDetail"];
            NSString *qty = [listFields objectForKey:@"qty"];
            NSString *seq = @"";
            [cell setProduct:product description:descDetail qty:qty amount:poAmount seq:seq];
        }
    }
    return cell;
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
            [mainClass stDictionaryApproval:responseData];
            self.dictionary = [mainClass getDictionaryApproval];
            //self.dictionary = responseData;
            NSDictionary *content = [self.dictionary objectForKey:@"content"];
            if (content) {
                NSString *nextLevel = [content objectForKey:@"nextLevel"];
                if ([nextLevel isEqualToString:@""]) {  //represent to end of approve flow
                    [mainClass alert:@"Approve completed."];
                    [headerClass stWillCloseNextAppear:@"Y"];
                    [self dismissViewControllerAnimated:YES completion:nil];
                } else {
                    self.canGo = YES;
                    [self performSegueWithIdentifier:@"ApprovalSegue" sender:self];
                }
            }
        } else if (connector==self.connector2) {
            [mainClass stDictionaryDetail:responseData];
            self.canGo = YES;
            [self performSegueWithIdentifier:@"HeaderSegue" sender:self];
        } else if (connector==self.connector3) {
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
