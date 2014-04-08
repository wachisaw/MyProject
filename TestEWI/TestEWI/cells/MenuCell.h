//
//  MenuCell.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

//by drag
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *name;


//by manual
- (void)setCompany:(NSString*)company name:(NSString*)name;



@end
