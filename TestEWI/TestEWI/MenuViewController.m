//
//  MenuViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "ViewController.h"
#import "AccessViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userlabel;
@property (assign) BOOL canGo;
@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;
@property (strong) NSString *selectedProgram;
@property (strong) NSString *selectedCompany;
- (IBAction)signoffBtn:(id)sender;
-(void) setArray;
-(void) requestSelectMenuPO;
-(void) requestSignoff;
@end

@implementation MenuViewController

@synthesize newsArray;
@synthesize newsArray2;
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
    
    if ([mainClass getIsTest]) {
        self.userlabel.text = [mainClass getUserName];
        [self setArray];
    } else {
        self.userlabel.text = [mainClass getUserName];
        self.dictionary = [mainClass getDictionaryMenu];
        NSDictionary *content = [self.dictionary objectForKey:@"content"];
        if (content) {
            self.data = [content objectForKey:@"listMenu_appPOCollection"];
            [self.tableView reloadData];
        }
    }
    
}

/*-(void) requestGetMenu {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step050getmenu";
    [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}*/

- (IBAction)signoffBtn:(id)sender {
    if ([mainClass getIsTest]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self requestSignoff];
    }
}

- (void) requestSignoff {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    if (self.connector2 == nil) {
        self.connector2 = [EWIJsonConnector connector];
        self.connector2.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"signoffformenu";
    [self.connector2 requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
    NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
}


-(void) setArray {
    self.newsArray = [[NSArray alloc] initWithObjects:@"MSC",@"MSC",@"HIS", nil];
    self.newsArray2 = [[NSArray alloc] initWithObjects:@"Approve PR/PO",@"Approve Debit Memo",@"Approve PR/PO", nil];
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
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        [cell setCompany:[newsArray objectAtIndex:row] name:[newsArray2 objectAtIndex:row]];
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"listMenu_appPO"];
            NSString *companyMenu = [listFields objectForKey:@"companyMenu"];
            NSString *programMenu = [listFields objectForKey:@"programMenu"];
            [cell setCompany:companyMenu name:programMenu];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if ([mainClass getIsTest]) {
        self.canGo = YES;
        [self performSegueWithIdentifier:@"DocListSegue" sender:self];
        NSString *programMenu = [newsArray2 objectAtIndex:row];
        NSLog(@"%@",programMenu);
    } else {
        NSDictionary *dict = [self.data objectAtIndex:row];
        if (dict) {
            NSDictionary *listFields = [dict objectForKey:@"listMenu_appPO"];
            self.selectedCompany = [listFields objectForKey:@"companyMenu"];
            self.selectedProgram = [listFields objectForKey:@"programMenu"];
            if ([self.selectedProgram isEqualToString:@"Approve PR/PO"]) {
                [self requestSelectMenuPO];
            } else {
                [mainClass alert:@"Program you selected not available on mobile."];
            }
            
        }
    }
}

- (void) requestSelectMenuPO {
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[mainClass getUserName] forKey:@"username"];
    [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
    [reqData setObject:self.selectedCompany forKey:@"company"];
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    NSString *serviceName = [[NSString alloc] init];
    serviceName = @"approvepo_step100selectmenu";
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
            self.canGo = YES;
            [self performSegueWithIdentifier:@"DocListSegue" sender:self];
        } else if (connector==self.connector2) {
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
