//
//  DetailCell.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/2/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(NSString *)code description:(NSString*)description qty:(NSString*)qty amount:(NSString*)amount seq:(NSString*)seq {
    self.productCode.text = code;
    self.productDescription.text = description;
    self.productQty.text = qty;
    self.productAmount.text = amount;
    self.productSeq.text = @"";
}
@end
