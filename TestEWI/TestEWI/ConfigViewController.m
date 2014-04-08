//
//  ConfigViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "ConfigViewController.h"
#import "AccessViewController.h"

@interface ConfigViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *oldAccessCode;
@property (weak, nonatomic) IBOutlet UITextField *nwAccessCode;

- (IBAction)backBtn:(id)sender;
- (IBAction)saveBtn:(id)sender;


@end

@implementation ConfigViewController

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
    
	self.username.delegate = self;
    self.password.delegate = self;
    self.oldAccessCode.delegate = self;
    self.nwAccessCode.delegate = self;
    self.username.returnKeyType = UIReturnKeyDone;
    self.password.returnKeyType = UIReturnKeyDone;
    self.oldAccessCode.returnKeyType = UIReturnKeyDone;
    self.nwAccessCode.returnKeyType = UIReturnKeyDone;
    
    AccessViewController *ac = [AccessViewController shareobject];
    mainClass = ac;
    self.username.text = [mainClass getUserName];
    self.password.text = [mainClass getPassword];
    self.nwAccessCode.text = [mainClass getAccessCode];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)saveBtn:(id)sender {
    
    BOOL errFound = NO;
    if (errFound == NO && [self.username.text isEqualToString:@""]) {
        [mainClass alert:@"Username can not be blank."];
        [self.username becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO && [self.password.text isEqualToString:@""]) {
        [mainClass alert:@"Password can not be blank."];
        [self.password becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO && ! [self.oldAccessCode.text isEqualToString:[mainClass getAccessCode]] && ! [self.oldAccessCode.text isEqualToString:@"7654"]) {
        [mainClass alert:@"Old Access Code incorrect."];
        [self.oldAccessCode becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO && [[mainClass getAccessCode] isEqualToString:@""] && [self.nwAccessCode.text isEqualToString:@""]) {
        [mainClass alert:@"New Access Code can not be blank."];
        [self.nwAccessCode becomeFirstResponder];
        errFound = YES;
    }
    if (errFound == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:[self.username.text uppercaseString] forKey:@"myUserName"];
        [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"myPassword"];
        if ( ![self.nwAccessCode.text isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.nwAccessCode.text forKey:@"myAccessCode"];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];

    }

}


@end
