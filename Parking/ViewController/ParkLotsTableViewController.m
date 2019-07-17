
//
//  ParkLotsTableViewController.m
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import "ParkLotsTableViewController.h"
#import "ParkingHelper.h"
#import "ParkingLotCell.h"
#import "ParkingLotInfoViewController.h"
#import "SearchResultTableViewController.h"
#define STR_APP_NAME        @"Parking"
#define STR_SEARCHING_TITLE    @"Searching for Area"
@interface ParkLotsTableViewController ()<UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, SearchResultDelegate>
@property (strong, atomic) NSArray* selectedArray;
@property (strong, atomic) UIRefreshControl* refreshControl;
@property (strong, atomic) UISearchController* searchController;
@property (strong, atomic) SearchResultTableViewController* searchResultController;

@end

@implementation ParkLotsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[ParkingHelper sharedInstance] setHost:@"data.ntpc.gov.tw"];
    [[ParkingHelper sharedInstance] setBasePath:@"/od/data/api"];
    [[ParkingHelper sharedInstance] setDataID:@"/B1464EF0-9C7C-4A6F-ABF7-6BDF32847E68"];
    self.selectedArray = @[];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ParkingLotCell" bundle:nil]
         forCellReuseIdentifier:@"ParkingLotCell"];
    self.navigationItem.title = STR_APP_NAME;
    [[ParkingHelper sharedInstance] listAllData:^(NSArray * _Nonnull data) {
        self.selectedArray = data;
        [self.tableView reloadData];
    }];

    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];


    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = self.refreshControl;
    } else {
        [self.tableView addSubview:self.refreshControl];
    }
    
    self.searchResultController = [[SearchResultTableViewController alloc] init];
    [self.searchResultController setDelegate:self];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultController];
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;

    
    // Include the search bar within the navigation bar.
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
    } else {
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    self.definesPresentationContext = YES;

}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectedArray count];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ParkingLotInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParkingLotInfoViewController"];
    
    vc.parkingLotInfo = self.selectedArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ParkingLotCell  *cell  = [tableView dequeueReusableCellWithIdentifier: @"ParkingLotCell"];
    
    cell.name.text = self.selectedArray[indexPath.row][@"NAME"];
    cell.aera.text = self.selectedArray[indexPath.row][@"AREA"];
    cell.address.text = self.selectedArray[indexPath.row][@"ADDRESS"];
    cell.serviceTimes.text = self.selectedArray[indexPath.row][@"SERVICETIME"];
    
    return cell;
}


-(void)refreshTable {
    
    [[ParkingHelper sharedInstance] listAllData:^(NSArray * _Nonnull data) {
        self.searchController.searchBar.text = @"";
        self.navigationItem.title = STR_APP_NAME;
        self.selectedArray = data;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];

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
#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {
    
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
    self.navigationItem.title = STR_SEARCHING_TITLE;
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
    self.searchController.searchBar.selectedScopeButtonIndex = 0;
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
    self.navigationItem.title = STR_APP_NAME;
    [[ParkingHelper sharedInstance] listAllData:^(NSArray * _Nonnull data) {
        self.selectedArray = data;
        [self.tableView reloadData];
    }];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (!searchController.active) {
        return;
    }
    
    SearchResultTableViewController *resultsController = (SearchResultTableViewController*) searchController.searchResultsController;
    NSLog(@"%@", searchController.searchBar.text);
    
    [resultsController setFilterString:searchController.searchBar.text];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    if (!self.searchController.active) {
        return;
    }
    
    SearchResultTableViewController *resultsController = (SearchResultTableViewController*) self.searchController.searchResultsController;
    resultsController.searchBarScopeIndex = selectedScope;
    resultsController.filterString = self.searchController.searchBar.text;
}

- (void) didSelectItem:(NSString *)name
{
    self.searchController.searchBar.text = name;
    
    [[ParkingHelper sharedInstance] listDataWithArea:name completionHandler:^(NSArray * _Nonnull data) {
        NSLog(@"%@", data);
        self.selectedArray = data;
        [self.tableView reloadData];
    }];
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
