#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <EventKit/EventKit.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Notification permission granted.");
        } else {
            NSLog(@"Permission denied: %@", error);
        }
    }];
        
    return YES;
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
     willPresentNotification:(UNNotification *)notification
           withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"Notification received in foreground: %@", notification.request.content.body);
    completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
     didReceiveNotificationResponse:(UNNotificationResponse *)response
                 withCompletionHandler:(void (^)(void))completionHandler {
    UNNotification *notification = response.notification;
    NSLog(@"User tapped the notification: %@", notification.request.content.body);
    
    completionHandler();
    [self deleteAllDeliveredNotifications];
}
- (void)deleteAllDeliveredNotifications {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    // Remove all delivered notifications
    [center removeAllDeliveredNotifications];
    
    NSLog(@"All delivered notifications have been deleted.");
}

@end
