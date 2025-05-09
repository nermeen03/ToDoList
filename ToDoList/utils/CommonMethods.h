//
//  CommonMethods.h
//  ToDoList
//
//  Created by Nermeen Mohamed on 08/05/2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethods : NSObject
+ (void)scheduleNotificationWithText:(NSString *)text atDate:(NSDate *)date notifyId:(NSString*) notifyId;

+ (void)scheduleNotificationWithContent:(NSString *)contentText atDate:(NSDate *)notificationDate notifyId:(NSString*) notifyId;

+ (void)deleteNotificationWithIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
