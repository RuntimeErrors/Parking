//
//  ParkingLotInfoViewController.m
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import "ParkingLotInfoViewController.h"
#import "ConvertCoordinate.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "InfoTableViewCell.h"

@interface ParkingLotInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, atomic)  NSArray* infoArray;

@end

@implementation ParkingLotInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CLLocationCoordinate2D location = [ConvertCoordinate GenerateWithTWD097X:[self.parkingLotInfo[@"TW97X"] doubleValue]
                                                                       TW97Y:[self.parkingLotInfo[@"TW97Y"] doubleValue]];
    MKCoordinateRegion digital;
    digital.center = location;
    // 設定縮放比例
    digital.span.latitudeDelta = 0.003;
    digital.span.longitudeDelta = 0.003;
    
    [self.mapView setRegion:digital];
    
    MKPointAnnotation* annotation= [MKPointAnnotation new];
    annotation.coordinate = location;
    annotation.title = self.parkingLotInfo[@"NAME"];
    annotation.subtitle = self.parkingLotInfo[@"SERVICETIME"];
    
    [self.mapView addAnnotation:annotation];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"InfoTableViewCell"];
    
    self.infoArray = @[@{@"Title":@"停車場稱",@"Message":self.parkingLotInfo[@"NAME"]},
                       @{@"Title":@"區域",@"Message":self.parkingLotInfo[@"AREA"]},
                       @{@"Title":@"營業時間",@"Message":self.parkingLotInfo[@"SERVICETIME"]},
                       @{@"Title":@"地址",@"Message":self.parkingLotInfo[@"ADDRESS"]}];
    
    self.navigationItem.title = self.parkingLotInfo[@"NAME"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.infoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell  *cell  = [tableView dequeueReusableCellWithIdentifier: @"InfoTableViewCell"];
    
    cell.mTitle.text = self.infoArray[indexPath.row][@"Title"];
    cell.mMessage.text = self.infoArray[indexPath.row][@"Message"];
    
    return cell;
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
