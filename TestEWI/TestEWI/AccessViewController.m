//
//  AccessViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "AccessViewController.h"

@interface AccessViewController ()

@property (strong)EWIJsonConnector *connector;
@property (weak, nonatomic) IBOutlet UITextField *accessCode;
@property (assign) BOOL canGo;
-(IBAction)signonBtn:(id)sender;
-(IBAction)configBtn:(id)sender;
-(void) requestSignon;


@end



@implementation AccessViewController

static id instance;
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
    
	instance = self;
    mainClass = self;
    
    self.ewiServer = @"http://172.16.26.111/apppo/jsonservice/";
    self.myToken = @"123";
    self.isTest = @"N";
    
    //[self refreshUserDefault]; move to viewDidAppear

}

-(void) refreshUserDefault {
    
    self.myUserName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserName"];
    self.myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"myPassword"];
    self.myAccessCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"myAccessCode"];
    if (self.myUserName == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"myUserName"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"myPassword"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"myAccessCode"];
        self.myUserName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myUserName"];
        self.myPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"myPassword"];
        self.myAccessCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"myAccessCode"];
    }
    
    self.userLabel.text = self.myUserName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signonBtn:(id)sender {
    BOOL errFound = NO;
    if (errFound == NO && [[mainClass getUserName] isEqualToString:@""]) {
        [self alert:@"Require configure before."];
        errFound = YES;
    }
    if (errFound == NO && [self.accessCode.text isEqualToString:@""]) {
        [self alert:@"Access Code can not be blank."];
        [self.accessCode becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO && ! [self.accessCode.text isEqualToString:[mainClass getAccessCode]]) {
        [self alert:@"Access Code incorrect."];
        [self.accessCode becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO) {
        [self requestSignon];
    }
}

- (IBAction)configBtn:(id)sender {
    self.canGo = YES;
    [self performSegueWithIdentifier:@"ConfigSegue" sender:self];
}

- (void) requestSignon {
    if ([mainClass getIsTest]) {
        self.canGo = YES;
        [self performSegueWithIdentifier:@"MainMenuSegue2" sender:self];
    } else {
        NSMutableDictionary *reqData = [NSMutableDictionary dictionary];
        [reqData setObject:[mainClass getUserName] forKey:@"username"];
        [reqData setObject:[mainClass getPassword] forKey:@"password"];
        [reqData setObject:[mainClass getToken] forKey:@"ewitoken"];
        self.accessCode.text = @"";
        if (self.connector == nil) {
            self.connector = [EWIJsonConnector connector];
            self.connector.delegate = self;
        }
        NSString *serviceName = [[NSString alloc] init];
        serviceName = @"signonapprovepo_getmenulist";
        [self.connector requestEWIService:[[mainClass getEWIServer] stringByAppendingString:serviceName  ] requestData:reqData];
        NSLog(@"%@",[[mainClass getEWIServer] stringByAppendingString:serviceName]);
    }
}

-(void) alert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:message delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)viewDidAppear:(BOOL)animated{
    [self refreshUserDefault];
    [self.accessCode becomeFirstResponder];
    self.canGo = NO;
    self.accessCode.text = @"";
}

+ (id)shareobject {
    return instance;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return self.canGo;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (NSString *)getUserName {
    return self.myUserName;
}

- (NSString *)getAccessCode {
    return self.myAccessCode;
}

- (NSString *)getPassword {
    return self.myPassword;
}

- (NSString *)getToken {
    return self.myToken;
}

- (NSString *)getEWIServer {
    return self.ewiServer;
}

- (BOOL) getIsTest {
    if ([self.isTest isEqualToString:@"Y"]) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDictionary *)getDictionaryMenu {
    return self.dictionaryMenu;
}

- (void) stDictionaryMenu:(NSDictionary *)dictionaryMenu {
    self.dictionaryMenu = dictionaryMenu;
}

- (NSDictionary *)getDictionaryDoc {
    return self.dictionaryDoc;
}

- (void) stDictionaryDoc:(NSDictionary *)dictionaryDoc {
    self.dictionaryDoc = dictionaryDoc;
}

- (NSDictionary *)getDictionaryDetail {
    return self.dictionaryDetail;
}

- (void) stDictionaryDetail:(NSDictionary *)dictionaryDetail {
    self.dictionaryDetail = dictionaryDetail;
}

- (NSDictionary *)getDictionaryApproval {
    return self.dictionaryApproval;
}

- (void) stDictionaryApproval:(NSDictionary *)dictionaryApproval {
    self.dictionaryApproval = dictionaryApproval;
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
            [mainClass stDictionaryMenu:responseData];
            self.canGo = YES;
            [self performSegueWithIdentifier:@"MainMenuSegue2" sender:self];
            //NSDictionary *content = [responseData objectForKey:@"content"];
            //if (content) {
            //    NSArray *listMenu = [content objectForKey:@"listMenu_appPOCollection"];
            //}
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
