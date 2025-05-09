//
//  CustomCellVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 08/05/2025.
//

#import "CustomCellVC.h"

@implementation CustomCellVC

- (void)awakeFromNib {
    [super awakeFromNib];
    [_dateValue setEnabled:NO];

    self.contentView.layer.cornerRadius = 8.0;
    self.contentView.layer.masksToBounds = YES;

    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowRadius = 4.0;
    self.layer.shadowOpacity = 0.2;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
