//
//  ConvertCoordinate.h
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ConvertCoordinate : NSObject
+(CLLocationCoordinate2D) GenerateWithTWD097X:(double)X TW97Y:(double)Y;
@end

NS_ASSUME_NONNULL_END
