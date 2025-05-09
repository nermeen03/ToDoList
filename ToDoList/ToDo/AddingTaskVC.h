//
//  AddingTaskVC.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <UIKit/UIKit.h>
#import "List.h"
#import "ToDoAddDelegate.h"
#import "UserDefaultMethods.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddingTaskVC : UIViewController<UIDocumentPickerDelegate>
@property (nonatomic, weak) id<ToDoAddDelegate> ref;

@end

NS_ASSUME_NONNULL_END
