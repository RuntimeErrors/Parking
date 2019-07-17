//
//  ParkingLotCell.h
//  Parking
//
//  Created by 蔡維昌 on 2019/7/15.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParkingLotCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *aera;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimes;

@end

NS_ASSUME_NONNULL_END
