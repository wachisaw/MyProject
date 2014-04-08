//
//  DocCell.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *poNo;
@property (weak, nonatomic) IBOutlet UILabel *poDesc;
@property (weak, nonatomic) IBOutlet UILabel *poAmt;
@property (weak, nonatomic) IBOutlet UILabel *poDDS;
@property (weak, nonatomic) IBOutlet UILabel *poType;

- (void)setNumber:(NSString *)poNo Amount:(NSString*)poAmt description:(NSString*)poDesc dds:(NSString *)poDDS typ:(NSString *)poType;
@end
