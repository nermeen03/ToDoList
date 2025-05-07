//
//  ToDoTVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "ToDoTVC.h"
#import "AddingTaskVC.h"

@interface ToDoTVC ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;

@property NSMutableArray<List *> *arr;
@property NSArray *filteredArray;
@property NSMutableArray<List *> *high;
@property NSMutableArray<List *> *medium;
@property NSMutableArray<List *> *low;

@end

@implementation ToDoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _toDoTable.delegate = self;
    _toDoTable.dataSource = self;
    self.searchBar.delegate = self;

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStyleDone
    target:self action:@selector(rightButtonTapped)];

    self.navigationItem.rightBarButtonItem = rightButton;
    [self refreshTable];
}

- (void)refreshTable {
    self.arr = [UserDefaultMethods getToDo];
    [self seperate];
    self.filteredArray = @[self.high, self.medium, self.low];

    [self.toDoTable reloadData];
}

- (void)seperate {
    self.high = [NSMutableArray array];
    self.medium = [NSMutableArray array];
    self.low = [NSMutableArray array];

    for (List *item in self.arr) {
        switch (item.priority) {
            case 0:
                [self.high addObject:item];
                break;
            case 1:
                [self.medium addObject:item];
                break;
            case 2:
                [self.low addObject:item];
                break;
            default:
                break;
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.filteredArray = @[self.high, self.medium, self.low];
    } else {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@", searchText];
        
        NSArray *filteredHigh = [self.high filteredArrayUsingPredicate:predicate];
        NSArray *filteredMedium = [self.medium filteredArrayUsingPredicate:predicate];
        NSArray *filteredLow = [self.low filteredArrayUsingPredicate:predicate];
        
        self.filteredArray = @[filteredHigh, filteredMedium, filteredLow];
    }

    [self.toDoTable reloadData];
}

- (void)rightButtonTapped {
    AddingTaskVC *aVC = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    aVC.ref = self;
    [self presentViewController:aVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"High Priority";
        case 1:
            return @"Medium Priority";
        case 2:
            return @"Low Priority";
        default:
            return @"Unknown Priority";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.high.count;
        case 1:
            return self.medium.count;
        case 2:
            return self.low.count;
        default:
            return 0;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    
    List *list = self.filteredArray[indexPath.section][indexPath.row];
    cell.textLabel.text = list.name;
    NSString *priorityImageName = (list.priority == 0) ? @"high" : (list.priority == 1) ? @"medium" : @"low";
    cell.imageView.image = [UIImage imageNamed:priorityImageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert!!"
            message:@"Do you want to delete?"
            preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            List *taskToDelete = self.filteredArray[indexPath.section][indexPath.row];
            NSMutableArray *arrayToUpdate;
            switch (indexPath.section) {
                case 0:
                    arrayToUpdate = self.high;
                    break;
                case 1:
                    arrayToUpdate = self.medium;
                    break;
                case 2:
                    arrayToUpdate = self.low;
                    break;
                default:
                    break;
            }
            
            [arrayToUpdate removeObject:taskToDelete];

            NSMutableArray *combinedArray = [NSMutableArray array];
            [combinedArray addObjectsFromArray:self.high];
            [combinedArray addObjectsFromArray:self.medium];
            [combinedArray addObjectsFromArray:self.low];
            
            [UserDefaultMethods setToDo:combinedArray];

            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self refreshTable];
        }];
        
        [alert addAction:dismiss];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsVC *pVC = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    pVC.ref = self;
    pVC.task = self.filteredArray[indexPath.section][indexPath.row];
    pVC.arr = _arr;
    NSLog(@"filt %@",self.filteredArray[indexPath.section][indexPath.row]);
    
    [self.navigationController pushViewController:pVC animated:YES];
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
