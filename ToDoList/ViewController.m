//
//  ViewController.m
//  AppObjectiveC
//
//  Created by Nermeen Mohamed on 29/04/2025.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
    
    [self.image addGestureRecognizer:tapGesture];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(timerFired)
                                       userInfo:nil
                                        repeats:NO];
}

- (void)timerFired {
    TabBarVC *tVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBar"];
    [self.navigationController setViewControllers:@[tVC] animated:YES];
    
}


- (void)imageTapped {
    TabBarVC *tVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBar"];
    [self.navigationController setViewControllers:@[tVC] animated:YES];
}
@end
