//
//  InfoTableViewCell.h
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UILabel *mMessage;

@end

NS_ASSUME_NONNULL_END
