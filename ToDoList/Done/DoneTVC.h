//
//  DoneTVC.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <UIKit/UIKit.h>
#import "UserDefaultMethods.h"
#import "DetailsVC.h"
#import "ToDoAddDelegate.h"
#import "CustomCellVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DoneTVC : UIViewController<UITableViewDelegate,UITableViewDataSource,ToDoAddDelegate>

@end

NS_ASSUME_NONNULL_END
