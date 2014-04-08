//
//  HeaderViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface HeaderViewController : UIViewController<EWIConnectorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UILabel *requester;
@property (weak, nonatomic) IBOutlet UILabel *description1;
@property (weak, nonatomic) IBOutlet UILabel *vendorName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *vatAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *overseaAmount;
@property (weak, nonatomic) IBOutlet UILabel *docDate;
@property (strong) NSDictionary *dictionary;
@property (strong) NSString *willCloseNextAppear;

+ (id)shareobject;
- (void) stWillCloseNextAppear:(NSString *)willCloseNextAppear;

@end
