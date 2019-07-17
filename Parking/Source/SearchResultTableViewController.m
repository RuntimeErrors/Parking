//
//  SearchResultTableViewController.m
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "ParkingHelper.h"
@interface SearchResultTableViewController ()
@property (nonatomic, strong) NSMutableArray *visibleResults;
@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil]
         forCellReuseIdentifier:@"SearchResultCell"];
    
    if([[[ParkingHelper sharedInstance] areas] count] != 0)
    {
        self.allResults =[[ParkingHelper sharedInstance] areas];
        self.visibleResults = [[NSMutableArray alloc] initWithArray:[[ParkingHelper sharedInstance] areas]];
    }
    else
        self.visibleResults = [[NSMutableArray alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.visibleResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.visibleResults objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", [self.visibleResults objectAtIndex:indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didSelectItem:[self.visibleResults objectAtIndex:indexPath.row]];
    }];
    
    
}

#pragma mark - Property Overrides & Filter Strategy
- (void)setFilterString:(NSString *)filterString {
    _filterString = filterString;
    self.visibleResults = [self.allResults mutableCopy];

    if (!filterString || filterString.length <= 0) {
        return;
    }
    else {
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF like  %@", [filterString stringByAppendingString:@"*"]];
        
        [self.visibleResults filterUsingPredicate:[namePredicate predicateWithSubstitutionVariables:@{@"nameString":filterString}]];
    }
    
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    
    
    [self.tableView reloadData];
}

@end
