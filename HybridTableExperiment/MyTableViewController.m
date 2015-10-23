#define DYNAMIC_SECTION 2

#import "MyTableViewController.h"

@interface MyTableViewController ()
@property (strong, nonatomic)NSArray *myArray;
@end

@implementation MyTableViewController

- (void)viewDidLoad {
    _myArray = @[@"ONE", @"TWO", @"THREE", @"FOUR"];
    self.tableView.rowHeight = 44.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section != DYNAMIC_SECTION) {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    return [self.myArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != DYNAMIC_SECTION) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    static NSString *id = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    cell.textLabel.text = self.myArray[indexPath.row];
    return cell;
}

// required
-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == DYNAMIC_SECTION) {
        return [super tableView:tableView indentationLevelForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    } else {
        return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
}

// Not required
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section != DYNAMIC_SECTION) {
        return [super tableView:tableView titleForHeaderInSection:section];
    }
    return @"some title";
}

//required
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == DYNAMIC_SECTION) {
        return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    } else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end