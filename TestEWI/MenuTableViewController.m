//
//  MenuTableViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuCell.h"
#import "ViewController.h"

@interface MenuTableViewController ()

//by manual
@property (strong)EWIJsonConnector *connector;
@property (strong)EWIJsonConnector *connector2;

//by drag
- (IBAction)signoffBtn:(id)sender;

@end

@implementation MenuTableViewController

//by manual
static id instance;


//------------------------------------------------------------------------------------------------------------------------------
//system define method
//------------------------------------------------------------------------------------------------------------------------------

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    instance = self;
    
    [self getMenuList];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.data!=nil) {
        return [self.data count];
    }
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSLog(@"Reload2");
    
    static NSString *CellIdentifier = @"cell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    //NSLog(@"Reload2");
    NSInteger row = indexPath.row;
    
    NSDictionary *dict = [self.data objectAtIndex:row];
    
    
    
    //NSLog(@"%@", dict);
    
    
    if (dict) {
        
        NSDictionary *listMenu_appPO = [dict objectForKey:@"listMenu_appPO"];
        
        NSString *companyMenu = [listMenu_appPO objectForKey:@"companyMenu"];
        NSString *programMenu = [listMenu_appPO objectForKey:@"programMenu"];
        
        [cell setCompany:companyMenu name:programMenu];
    }
    
    
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
//------------------------------------------------------------------------------------------------------------------------------
//interactive method
//------------------------------------------------------------------------------------------------------------------------------

- (IBAction)signoffBtn:(id)sender {
    
    ViewController *vc = [ViewController shareobject];
    
    //setup data
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[vc getUserName] forKey:@"username"];
    //[reqData setObject:[vc getPassword] forKey:@"password"];
    [reqData setObject:[vc getToken] forKey:@"ewitoken"];
    
    
    if (self.connector2 == nil) {
        self.connector2 = [EWIJsonConnector connector];
        self.connector2.delegate = self;
    }
    
    [self.connector2 requestEWIService:@"http://172.16.26.111/ApprovePO/jsonservice/listmenu_apppo" requestData:reqData];
    
}


//------------------------------------------------------------------------------------------------------------------------------
//manual method
//------------------------------------------------------------------------------------------------------------------------------

+ (id)shareobject {
    return instance;
}


- (void) closeMe {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) getMenuList {
    ViewController *vc = [ViewController shareobject];
    
    //setup data
    NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
    [reqData setObject:[vc getUserName] forKey:@"username"];
    //[reqData setObject:[vc getPassword] forKey:@"password"];
    [reqData setObject:[vc getToken] forKey:@"ewitoken"];
    
    
    if (self.connector == nil) {
        self.connector = [EWIJsonConnector connector];
        self.connector.delegate = self;
    }
    
    //connect
    [self.connector requestEWIService:@"http://172.16.26.111/ApprovePO/jsonservice/listmenu_apppo" requestData:reqData];
    
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
        
        if (connector==self.connector) {
            
            NSDictionary *content = [responseData objectForKey:@"content"];
            if (content) {
                NSArray *listMenu = [content objectForKey:@"listMenu_appPOCollection"];
                
                self.data = listMenu;
                
                //NSLog(@"%@", self.data);
                
                [self.tableView reloadData];
                
            }
            
        }else {
            // press signoff and then service from as400=OK
            
            [self closeMe];
            
            //command logon form to clear password
            //ViewController *vc = [ViewController shareobject];
            //[vc clearPassword];
            
        }
        
        //[self performSegueWithIdentifier:@"MainMenuSegue" sender:self];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert windows" message:Runmessage delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)requestEWIServiceFail:(EWIJsonConnector*)connector{
    NSLog(@"requestEWIServiceFail %@", connector);
}




@end
