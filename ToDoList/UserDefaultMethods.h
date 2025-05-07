//
//  UserDefaultMethods.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <Foundation/Foundation.h>
#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultMethods : NSObject
+ (NSMutableArray<List *> *) getToDo;
+(void) setToDo:(NSMutableArray*) data;

+ (NSMutableArray<List *> *)getDoing;
+(void) setDoing:(NSMutableArray*) data;
@end

NS_ASSUME_NONNULL_END
