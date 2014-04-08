//
//  InputAccessViewController.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "InputAccessViewController.h"

@interface InputAccessViewController ()

//by drag
//@property (weak, nonatomic) IBOutlet UITextField *Input;

@end




@implementation InputAccessViewController

//by manual
static id instance;


//------------------------------------------------------------------------------------------------------------------------------
//system define method
//------------------------------------------------------------------------------------------------------------------------------

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
}

//show keyboard auto
- (void)viewDidAppear:(BOOL)animated{
    //[self.Input becomeFirstResponder];
}


//------------------------------------------------------------------------------------------------------------------------------
//interactive method
//------------------------------------------------------------------------------------------------------------------------------


//------------------------------------------------------------------------------------------------------------------------------
//manual method
//------------------------------------------------------------------------------------------------------------------------------

+ (id)shareobject {
    return instance;
}

- (void) closeMe {
    [self dismissViewControllerAnimated:YES completion:nil];
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
@end
