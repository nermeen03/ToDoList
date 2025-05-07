//
//  DoingTVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "DoingTVC.h"

@interface DoingTVC ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property NSMutableArray *arr;
@property NSArray *shown;
@end

@implementation DoingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _arr = [UserDefaultMethods getDoing];
    _shown = @[[_arr copy]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _shown.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_shown[section] count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *ident = @"doing";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    List *list = _shown[indexPath.section][indexPath.row];
    cell.textLabel.text = list.name;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert!!"
            message:@"Do you want to delete?"
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
            style:UIAlertActionStyleCancel
            handler:nil];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes"
           style:UIAlertActionStyleDestructive
           handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *delete = [self.shown[indexPath.section]mutableCopy];
            [self.arr removeObject:delete];
            [UserDefaultMethods setDoing:self->_arr];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView reloadData];
        }];
        
        [alert addAction:dismiss];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsVC *pVC = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    pVC.index = indexPath.row;
    pVC.task = _arr[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:pVC animated:YES];
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
