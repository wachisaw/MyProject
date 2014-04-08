//
//  DetailCell.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/2/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productCode;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *productQty;
@property (weak, nonatomic) IBOutlet UILabel *productAmount;
@property (weak, nonatomic) IBOutlet UILabel *productSeq;




- (void)setProduct:(NSString *)code description:(NSString*)description qty:(NSString*)qty amount:(NSString*)amount seq:(NSString*)seq;

@end
