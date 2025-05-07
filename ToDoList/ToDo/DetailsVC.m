//
//  DetailsVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "DetailsVC.h"

@interface DetailsVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextView *descField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *notifyField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;
@property NSInteger prio;
@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"add %@",_task);
    [_dateField setMinimumDate: [NSDate date]];
    _prio = _task.priority;
    _nameField.enabled = NO;
    _descField.editable = NO;
    _priority.enabled = NO;
    _dateField.enabled = NO;
    _notifyField.enabled = NO;
    _status.enabled = NO;
    
    _nameField.text = _task.name;
    _descField.text = _task.desc;
    _priority.selectedSegmentIndex = _task.priority;
    _dateField.date = _task.date;
    _notifyField.selectedSegmentIndex = _task.notify ? YES : NO;
    _status.selectedSegmentIndex = _task.status;
    
}
- (IBAction)edit:(id)sender {
    NSString *currentTitle = [_button titleForState:UIControlStateNormal];

    if ([currentTitle isEqualToString:@"Edit"]) {
        [_button setTitle:@"Save" forState:UIControlStateNormal];
        _nameField.enabled = YES;
        _descField.editable = YES;
        _priority.enabled = YES;
        _dateField.enabled = YES;
        _notifyField.enabled = YES;
        _status.enabled = YES;

    } else {
        [_button setTitle:@"Edit" forState:UIControlStateNormal];
        _nameField.enabled = NO;
        _descField.editable = NO;
        _priority.enabled = NO;
        _dateField.enabled = NO;
        _notifyField.enabled = NO;
        _status.enabled = NO;
        
      
        [_task setName:_nameField.text desc:_descField.text priority:_priority.selectedSegmentIndex date:_dateField.date notify:(_notifyField.selectedSegmentIndex == 0) ? NO : YES status:_status.selectedSegmentIndex];
        
        NSLog(@"refresh %@", _task.desc);
        
         if(_status.selectedSegmentIndex == 0){
             [UserDefaultMethods setToDo:_arr];
             [_ref refreshTable];
         }
         if(_status.selectedSegmentIndex == 1){
             [_arr removeObject:_task];
             [UserDefaultMethods setToDo:_arr];
             NSMutableArray *doingTasks = [UserDefaultMethods getDoing];
             [doingTasks addObject:_task];
             [UserDefaultMethods setDoing:doingTasks];
             [_ref refreshTable];
         }
    }
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
