//
//  CustomCellVC.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 08/05/2025.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCellVC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateValue;


@end

NS_ASSUME_NONNULL_END
