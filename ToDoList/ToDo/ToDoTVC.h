//
//  ToDoTVC.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "UserDefaultMethods.h"
#import "ToDoAddDelegate.h"
#import "DetailsVC.h"
#import "AddingTaskVC.h"
#import "CustomCellVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTVC : UIViewController<UITableViewDelegate,UITableViewDataSource,ToDoAddDelegate,UISearchBarDelegate>

@end

NS_ASSUME_NONNULL_END
