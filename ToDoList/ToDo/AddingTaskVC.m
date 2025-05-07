//
//  AddingTaskVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "AddingTaskVC.h"

@interface AddingTaskVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextView *descField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *notifyField;
@property (weak, nonatomic) IBOutlet UILabel *message;

@property NSMutableString *error;
@property NSString *prio;
@property BOOL notify;
@property NSMutableArray *arr;



@end

@implementation AddingTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [UserDefaultMethods getToDo];
    self.error = [NSMutableString string];
    [self.dateField setMinimumDate:[NSDate date]];
    if (self.prioField.selectedSegmentIndex == UISegmentedControlNoSegment) {
        self.prioField.selectedSegmentIndex = 0;
    }
}
- (IBAction)addTask:(id)sender {
    [self.error setString:@""];
        
    [self checkName];
    [self getNotify];
    
    if (self.error.length > 0) {
        self.message.text = self.error;
        return;
    }
    
    NSDate *selectedDate = self.dateField.date;
    NSInteger priority = self.prioField.selectedSegmentIndex;
    NSLog(@"%ld",(long)priority);

    if (priority < 0 || priority > 2) {
            priority = 0;
        }
    List *list = [List new];
    [list setName:self.nameField.text desc:self.descField.text priority:priority date:selectedDate notify:self.notify status:0];
    
    [self.arr addObject:list];
    [UserDefaultMethods setToDo:self.arr];
    
    [self.ref refreshTable];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) checkName{
    if(_nameField.text.length <3){
        [_error appendString:@"name must be larger than 2, "];
    }
}

- (IBAction)priority:(id)sender {
    [self updatePriority];

}
- (void)updatePriority {
    NSString *selected = [self.prioField titleForSegmentAtIndex:self.prioField.selectedSegmentIndex];
    NSLog(@"%@",selected);
    _prio = [selected isEqualToString:@"Low"] ? @"l" : [selected isEqualToString:@"Medium"] ? @"m" : @"h";
    
}

- (void)getNotify {
    NSString *selected = [self.notifyField titleForSegmentAtIndex:self.notifyField.selectedSegmentIndex];
    self.notify = [selected isEqualToString:@"No"] ? NO : YES;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
