//
//  List.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface List : NSObject<NSCoding,NSSecureCoding,NSCopying>
@property NSString *name;
@property NSString *desc;
@property NSInteger priority;
@property NSDate *date;
@property (nonatomic) BOOL notify;
@property NSInteger status;
@property (nonatomic, strong) NSString *taskID;
@property (nonatomic, strong) NSString *notifyID;
@property (nonatomic, strong) NSString *savedFileName;
@property (nonatomic, strong) NSURL *savedFileURL;

- (void)setName:(NSString *)name desc:(NSString *)des priority:(NSInteger)prio date:(NSDate*) date notify:(BOOL)notify status:(NSInteger)status notifyId:(NSString*) str;

@end

NS_ASSUME_NONNULL_END
