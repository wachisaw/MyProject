//
//  HDDTTableViewController.h
//  TestEWI
//
//  Created by MSC on 11/11/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface HDDTTableViewController : UITableViewController<EWIConnectorDelegate>

@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UILabel *docDate;
@property (weak, nonatomic) IBOutlet UILabel *requester;
@property (weak, nonatomic) IBOutlet UILabel *description1;
@property (weak, nonatomic) IBOutlet UILabel *vendorName;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *vatAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *overseaAmount;
@property (strong) NSDictionary *dictionary;
@property (strong) NSString *willCloseNextAppear;

@property (strong, nonatomic) NSArray *newsArray;
@property (strong, nonatomic) NSArray *newsArray2;
@property (strong, nonatomic) NSArray *newsArray3;
@property (strong, nonatomic) NSArray *newsArray4;
@property (strong, nonatomic) NSArray *newsArray5;
@property (strong) NSArray *data;

+ (id)shareobject;
- (void) stWillCloseNextAppear:(NSString *)willCloseNextAppear;

@end
