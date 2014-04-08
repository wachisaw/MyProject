//
//  ReasonViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/6/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface ReasonViewController : UIViewController<EWIConnectorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UITextField *reason;
@property (strong) NSArray *data;
@property (strong) NSDictionary *dictionary;

@end
