//
//  CommonMethods.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 08/05/2025.
//

#import "CommonMethods.h"
#import <UserNotifications/UserNotifications.h>
#import <EventKit/EventKit.h>
@implementation CommonMethods

+ (void)scheduleNotificationWithText:(NSString *)text atDate:(NSDate *)date notifyId:(NSString*) notifyId {
    [CommonMethods scheduleNotificationWithContent:text atDate:date notifyId:notifyId];
}

+ (void)scheduleNotificationWithContent:(NSString *)contentText atDate:(NSDate *)notificationDate notifyId:(NSString*) notifyId{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Reminder";
        content.body = contentText;
        content.sound = [UNNotificationSound defaultSound];

        NSTimeInterval timeInterval = [notificationDate timeIntervalSinceNow];
        if (timeInterval < 0) {
            NSLog(@"The specified date is in the past.");
            return;
        }

        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];

        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notifyId content:content trigger:trigger];

        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error scheduling notification: %@", error);
            } else {
                NSLog(@"Notification scheduled with ID: %@", notifyId);
            }
        }];
}

+ (void)deleteNotificationWithIdentifier:(NSString *)identifier {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
    [center removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    NSLog(@"Notification with identifier %@ has been deleted", identifier);
}


@end
