//
//  DocViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "DocViewController.h"
#import "DocCell.h"
#import "AccessViewController.h"

@interface DocViewController ()
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;
@property (strong)EWIJsonConnector *connector3;
@property (strong) NSString *selectedDocNo;
@property (strong) NSString *selectedDocType;
- (IBAction)backBtn:(id)sender;
- (void) setArray;
- (void) requestDocList;
- (void) requestGetDocDetail;
- (void) requestBack;
@end

@implementation DocViewController

@synthesize newsArray;
@synthesize newsArray2;
@synthesize newsArray3;
@synthesize newsArray4;
@synthesize newsArray5;
@synthesize tableView;

static id mainClass;

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
}

- (IBAction)backBtn:(id)sender {
    if ([mainClass getIsTest]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self requestBack];
    }
}

- (void) requestBack {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector3 == nil) {
        self.connector3 = [EWIJsonConnector connector];
        self.connector3.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step910exitpgm";
    [self.connector3 requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}

-(void) setArray {
    self.newsArray = [[NSArray alloc] initWithObjects:@"13 00000123",@"13 00000214",@"13 00000556", nil];
    self.newsArray2 = [[NSArray alloc] initWithObjects:@"4,000,000",@"20,000",@"4,500", nil];
    self.newsArray3 = [[NSArray alloc] initWithObjects:@"Buy computer",@"Buy office supply",@"Sub contract service", nil];
    self.newsArray4 = [[NSArray alloc] initWithObjects:@"831",@"832",@"833", nil];
    self.newsArray5 = [[NSArray alloc] initWithObjects:@"PO",@"PR",@"PO", nil];
}

- (void)viewDidAppear:(BOOL)animated{
    self.canGo = NO;
    if ([mainClass getIsTest]) {
        [self setArray];
        [self.tableView reloadData];
    } else {
        [self requestDocList];
    }
}

- (void) requestDocList {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step150getdoclist";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.canGo;
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
    DocCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        [cell setNumber:[self.newsArray objectAtIndex:row] Amount:[self.newsArray2 objectAtIndex:row] description:[self.newsArray3 objectAtIndex:row] dds:[self.newsArray4 objectAtIndex:row] typ:[self.newsArray5 objectAtIndex:row]];
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"datalistPO"];
            NSString *docno = [listFields objectForKey:@"listDocNo"];
            NSString *doc = [listFields objectForKey:@"listDoc"];
            NSString *des = [listFields objectForKey:@"listDes"];
            NSString *dds = [listFields objectForKey:@"listDDS"];
            NSString *amount = [listFields objectForKey:@"listAmount"];
            [cell setNumber:docno Amount:amount description:des dds:dds typ:doc];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        self.canGo = YES;
        [self performSegueWithIdentifier:@"HDDTSegue" sender:self];
        NSString *docno = [newsArray objectAtIndex:row];
        NSLog(@"%@",docno);
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"datalistPO"];
            self.selectedDocNo = [listFields objectForKey:@"listDocNo"];
            self.selectedDocType = [listFields objectForKey:@"listDoc"];
            [self requestGetDocDetail];
        }
    }
}

- (void) requestGetDocDetail {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    [reqData setObject:self.selectedDocNo forKey:@"docNo"];
    [reqData setObject:self.selectedDocType forKey:@"doctyp"];
    if (self.connector2 == nil) {
        self.connector2 = [EWIJsonConnector connector];
        self.connector2.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step200selectdoc";
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
            [mainClass stDictionaryDoc:responseData];
            self.dictionary = [mainClass getDictionaryDoc];
            NSDictionary *content = [self.dictionary objectForKey:@"content"];
            if (content) {
                self.data = [content objectForKey:@"datalistPOCollection"];
                [self.tableView reloadData];
            }
        } else if (connector==self.connector2) {
            [mainClass stDictionaryDetail:responseData];
            self.canGo = YES;
            [self performSegueWithIdentifier:@"HDDTSegue" sender:self];
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
