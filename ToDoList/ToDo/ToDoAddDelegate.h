//
//  ToDoAddDelegate.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ToDoAddDelegate <NSObject>
- (void)refreshTable;

@end

NS_ASSUME_NONNULL_END
