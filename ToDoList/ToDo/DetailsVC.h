//
//  DetailsVC.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "UserDefaultMethods.h"
#import "ToDoAddDelegate.h"
#import "DoneTVC.h"
#import "ToDoTVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsVC : UIViewController<UIDocumentInteractionControllerDelegate,UIDocumentPickerDelegate>
@property List *task;
@property NSMutableArray *arr;
@property NSInteger index;
@property (nonatomic, weak) id<ToDoAddDelegate> ref;
@end

NS_ASSUME_NONNULL_END
