//
//  DetailsVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "DetailsVC.h"
#import "DoingTVC.h"
#import "CommonMethods.h"

@interface DetailsVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextView *descField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *notifyField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;
@property (weak, nonatomic) IBOutlet UILabel *MyNotify;
@property NSInteger prio;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *fileField;

@property (nonatomic, strong) NSString *savedFileName;
@property (nonatomic, strong) NSURL *savedFileURL;
@property (weak, nonatomic) IBOutlet UIButton *changeFile;

@end

@implementation DetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self mainInfo];
    
}

-(void) mainInfo{
    self.descField.layer.borderColor = [UIColor systemGray6Color].CGColor;
    self.descField.layer.borderWidth = 1.0;
    self.descField.layer.cornerRadius = 5.0;
    
    _prio = _task.priority;
    _nameField.enabled = NO;
    _descField.editable = NO;
    _priority.enabled = NO;
    _dateField.enabled = NO;
    _notifyField.enabled = NO;
    _status.enabled = NO;
    
    self.descField.alpha = 0.4;
    self.descField.backgroundColor = [UIColor systemGray6Color];
    
    _nameField.text = _task.name;
    _descField.text = _task.desc;
    _priority.selectedSegmentIndex = _task.priority;
    _dateField.date = _task.date;
    _notifyField.selectedSegmentIndex = _task.notify ? YES : NO;
    _status.selectedSegmentIndex = _task.status;
    _savedFileName = _task.savedFileName;
    _savedFileURL = _task.savedFileURL;
    
    if(_task.savedFileName == nil){
        [_fileField setHidden:YES];
        [_changeFile setHidden:YES];
    }else {
        [_changeFile setHidden:YES];
        [_fileField setHidden:NO];
        [_fileField setTitle:@"Open File" forState:UIControlStateNormal];

    }
    if([self.ref isKindOfClass:[DoingTVC class]]){
        [_status removeSegmentAtIndex:0 animated:NO];
        [_status insertSegmentWithTitle:@"" atIndex:0 animated:NO];
        
    }else if([self.ref isKindOfClass:[DoneTVC class]]){
        [_fileField removeFromSuperview];
        [_changeFile removeFromSuperview];
        [_status removeAllSegments];
        [_notifyField removeAllSegments];
        [self.myLabel removeFromSuperview];
        [self.MyNotify removeFromSuperview];
        [self.button removeFromSuperview];
        
    }
}

- (IBAction)edit:(id)sender {
    [_dateField setMinimumDate: [NSDate date]];
    NSString *currentTitle = [_button titleForState:UIControlStateNormal];
    if ([currentTitle isEqualToString:@"Save"]){
        [self->_button setTitle:@"Edit" forState:UIControlStateNormal];
        self->_nameField.enabled = NO;
        self->_descField.editable = NO;
        self->_priority.enabled = NO;
        self->_dateField.enabled = NO;
        self->_notifyField.enabled = NO;
        self->_status.enabled = NO;
        
        self.descField.alpha = 0.5;
        
        self.descField.backgroundColor = [UIColor systemGray6Color];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert!!" message:@"Do you want to Edit?"
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [self mainInfo];
        }];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        
            NSString *notifyIdOld = self->_task.notifyID?:[[NSUUID UUID] UUIDString];
            NSString *notifyId = [[NSUUID UUID] UUIDString];
            
            if (self->_task != nil) {
                [self->_task setName:self->_nameField.text
                desc:self->_descField.text
                priority:self->_priority.selectedSegmentIndex
                date:self->_dateField.date
                notify:(self->_notifyField.selectedSegmentIndex == 0) ? NO : YES
                status:self->_status.selectedSegmentIndex
                notifyId:notifyId];
                self->_task.savedFileName = self.savedFileName;
                self->_task.savedFileURL = self.savedFileURL;
                NSLog(@"name %@",self->_task.savedFileName);
                if(self->_task.savedFileName == nil){
                    [self->_fileField setHidden:YES];
                    [self->_changeFile setHidden:YES];
                }else {
                    [self->_changeFile setHidden:YES];
                    [self->_fileField setHidden:NO];
                    [self->_fileField setTitle:@"Open File" forState:UIControlStateNormal];

                }
            } else {
                NSLog(@"Error: task is nil");
                return;
            }

            if (self->_notifyField.selectedSegmentIndex == 1) {
                [CommonMethods deleteNotificationWithIdentifier:notifyIdOld];
                [CommonMethods scheduleNotificationWithText:self->_task.name
                                                     atDate:self->_task.date
                                                  notifyId:self->_task.notifyID];
            } else {
                [CommonMethods deleteNotificationWithIdentifier:notifyIdOld];
            }

            if (self->_status.selectedSegmentIndex == 0) {
                if (self->_arr != nil) {
                    [UserDefaultMethods setToDo:self->_arr];
                    [self->_ref refreshTable];
                } else {
                    NSLog(@"Error: _arr is nil");
                }
            }
            if (self->_status.selectedSegmentIndex == 1) {
                if (self->_arr != nil) {
                    if ([self.ref isKindOfClass:[ToDoTVC class]]){
                        [self->_arr removeObject:self->_task];
                        [UserDefaultMethods setToDo:self->_arr];
                    }else{
                        [self->_arr removeObject:self->_task];
                        [UserDefaultMethods setDoing:self->_arr];
                    }
                    NSMutableArray *doingTasks = [UserDefaultMethods getDoing];
                    if (doingTasks != nil) {
                        [doingTasks addObject:self->_task];
                        [UserDefaultMethods setDoing:doingTasks];
                        [self->_ref refreshTable];
                    } else {
                        NSLog(@"Error: doingTasks is nil");
                    }
                } else {
                    NSLog(@"Error: _arr is nil");
                }
            } else if (self->_status.selectedSegmentIndex == 2) {
                if ([self.ref isKindOfClass:[ToDoTVC class]]) {
                    [self->_arr removeObject:self->_task];
                    [UserDefaultMethods setToDo:self->_arr];
                } else {
                    [self->_arr removeObject:self->_task];
                    [UserDefaultMethods setDoing:self->_arr];
                }

                NSMutableArray *doneTasks = [UserDefaultMethods getDone];
                if (doneTasks != nil) {
                    [doneTasks addObject:self->_task];
                    [UserDefaultMethods setDone:doneTasks];
                    [self->_ref refreshTable];
                } else {
                    NSLog(@"Error: doneTasks is nil");
                }
            }
        }];
        
        [alert addAction:dismiss];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [_button setTitle:@"Save" forState:UIControlStateNormal];
        _nameField.enabled = YES;
        _descField.editable = YES;
        _priority.enabled = YES;
        _dateField.enabled = YES;
        _notifyField.enabled = YES;
        _status.enabled = YES;
        [self->_changeFile setHidden:NO];
        if(_task.savedFileName == NULL){
            [self->_fileField setHidden:YES];
        }else{
            [_fileField setTitle:@"Remove File" forState:UIControlStateNormal];
        }
        self.descField.layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

- (IBAction)openFile:(id)sender {
    NSString *currentTitle = [_fileField titleForState:UIControlStateNormal];
    NSLog(@"pressed");
    if([currentTitle isEqualToString:@"Remove File"]){
        _savedFileURL = nil;
        _savedFileName = nil;
        [_fileField setTitle:@"File Removed" forState:UIControlStateNormal];
    }else{
        [self openSavedFile:_task.savedFileName Url:_task.savedFileURL];
    }
}

- (void)openSavedFile:(NSString *)savedFileName Url:(NSURL *)savedFileURL {
    if (savedFileName && savedFileURL) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;

        NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:savedFileName];

        if ([[NSFileManager defaultManager] fileExistsAtPath:fileURL.path]) {
            UIDocumentInteractionController *docController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
            docController.delegate = self;

            [docController presentPreviewAnimated:YES];
        } else {
            NSLog(@"File not found at: %@", fileURL.path);
        }
    } else {
        NSLog(@"No file saved yet.");
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
    NSLog(@"Preview ended.");
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    NSLog(@"Sent to application: %@", application);
}

- (IBAction)changeButtonTapped:(id)sender {
    [self openDocumentPicker];
}

- (void)openDocumentPicker {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    NSURL *fileURL = urls.firstObject;

    NSString *fileName = fileURL.lastPathComponent;
    self.savedFileName = fileName;
    self.savedFileURL = fileURL;

    NSLog(@"File selected: %@", fileName);
    NSLog(@"File URL: %@", fileURL);

    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;

    NSURL *destinationURL = [documentsDirectoryURL URLByAppendingPathComponent:fileName];

    if ([[NSFileManager defaultManager] fileExistsAtPath:destinationURL.path]) {
        NSError *removeError;
        [[NSFileManager defaultManager] removeItemAtURL:destinationURL error:&removeError];
        if (removeError) {
            NSLog(@"Error removing existing file: %@", removeError.localizedDescription);
        }
    }

    NSError *error;
    [[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:destinationURL error:&error];

    if (error) {
        NSLog(@"Error saving file: %@", error.localizedDescription);
    } else {
        NSLog(@"File saved to: %@", destinationURL.path);
        [_changeFile setTitle:@"File Saved" forState:UIControlStateNormal];
    }
}


- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    NSLog(@"Document picker was cancelled");
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
