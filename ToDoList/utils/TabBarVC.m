//
//  TabBarVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 08/05/2025.
//

#import "TabBarVC.h"
#import "ToDoAddDelegate.h"
@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    UIViewController *targetVC = viewController;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            targetVC = ((UINavigationController *)viewController).visibleViewController;
        }

        if ([targetVC conformsToProtocol:@protocol(ToDoAddDelegate)]) {
            printf("getting refresh");
            [(id<ToDoAddDelegate>)targetVC refreshTable];
        }
}

@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
