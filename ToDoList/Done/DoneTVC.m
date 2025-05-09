//
//  DoneTVC.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "DoneTVC.h"

@interface DoneTVC ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property NSMutableArray *arr;
@property NSArray *shown;
@property UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;

@end

@implementation DoneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _arr = [UserDefaultMethods getDone];
    _shown = @[[NSMutableArray arrayWithArray:_arr]];
    _rightButton = [[UIBarButtonItem alloc]initWithTitle:@"Sort" style:UIBarButtonItemStyleDone
    target:self action:@selector(sortButtonTapped)];

    self.navigationItem.rightBarButtonItem = _rightButton;
    self.navigationItem.title = @"Done List";
    if(_arr.count ==  0){
        [_emptyImage setHidden:NO];
        self->_rightButton.hidden = YES;
        _emptyImage.image = [UIImage imageNamed:@"empty"];
    }else{
        [_emptyImage setHidden:YES];
        self->_rightButton.hidden = NO;
    }
}

-(void) sortButtonTapped{
    NSString *currentTitle = _rightButton.title;
    if ([currentTitle isEqualToString:@"Unsort"]){
        _rightButton.title = @"Sort";
        _shown = @[[_arr copy]];
        [self.myTable reloadData];
    }else{
        _rightButton.title = @"Unsort";
        [self seperate];
        [self.myTable reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _shown.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_shown[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *sectionArray = self.shown[section];
    return sectionArray.count > 0 ? 44 : 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *ident = @"done";
    CustomCellVC *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    List *list = _shown[indexPath.section][indexPath.row];
    cell.nameLabel.text = list.name;
    NSString *priorityImageName = (list.priority == 0) ? @"high" : (list.priority == 1) ? @"medium" : @"low";
    cell.imageIcon.image = [UIImage imageNamed:priorityImageName];
    cell.dateValue.date = list.date;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm Deletion"
            message:@"Are you sure you want to delete this task?"
            preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Cancel"
        style:UIAlertActionStyleDestructive handler:nil];

        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Yes"
        style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * _Nonnull action) {
            List *delete = self.shown[indexPath.section][indexPath.row];
            [self.arr removeObject:delete];
            [UserDefaultMethods setDone:self->_arr];
            
            NSLog(@"%ld",(long)indexPath.section);
            NSLog(@"%ld",(long)indexPath.row);
            
            if ([self->_rightButton.title isEqualToString:@"Unsort"]) {
                [self seperate];
            } else {
                self.shown = @[[NSMutableArray arrayWithArray:self.arr]];
            }
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
    pVC.task = self.shown[indexPath.section][indexPath.row];
    pVC.arr = _arr;
    NSLog(@"filt %@",self.shown[indexPath.section][indexPath.row]);
    
    [self.navigationController pushViewController:pVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *sectionArray = self.shown[section];
    if (sectionArray.count == 0) return nil;
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor labelColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    
    if(_shown.count==0){
        [_emptyImage setHidden:NO];
    }else if(_shown.count>1){
        switch (section) {
            case 0: label.text = @"  High Priority"; break;
            case 1: label.text = @"  Medium Priority"; break;
            case 2: label.text = @"  Low Priority"; break;
            default: label.text = @"  Unknown Priority"; break;
        }
    }

    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor systemBackgroundColor];

    label.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:label];

    // Separator line
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor lightGrayColor];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:separator];

    [NSLayoutConstraint activateConstraints:@[
        [separator.heightAnchor constraintEqualToConstant:1],
        [separator.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:10],
        [separator.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-10],
        [separator.bottomAnchor constraintEqualToAnchor:container.bottomAnchor]
    ]];

    return container;
}
- (void)refreshTable {
    _arr = [UserDefaultMethods getDone];
    _shown = @[[NSMutableArray arrayWithArray:_arr]];
    [self.myTable reloadData];
    if(self->_arr.count ==  0){
        [self->_emptyImage setHidden:NO];
        self->_rightButton.hidden = YES;
        self->_emptyImage.image = [UIImage imageNamed:@"empty"];
    }else{
        [self->_emptyImage setHidden:YES];
        self->_rightButton.hidden = NO;
    }
}

- (void)seperate {
    NSMutableArray *high = [NSMutableArray array];
    NSMutableArray *medium = [NSMutableArray array];
    NSMutableArray *low = [NSMutableArray array];

    for (List *item in self.arr) {
        switch (item.priority) {
            case 0:
                [high addObject:item];
                break;
            case 1:
                [medium addObject:item];
                break;
            case 2:
                [low addObject:item];
                break;
            default:
                break;
        }
    }
    _shown = @[high,medium,low];
}

@end
