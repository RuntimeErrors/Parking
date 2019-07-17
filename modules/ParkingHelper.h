//
//  ParkingHelper.h
//  Test API
//
//  Created by 蔡維昌 on 2019/7/15.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParkingHelper : NSObject
@property (strong, atomic) NSString* host;
@property (strong, atomic) NSString* basePath;
@property (strong, atomic) NSString* dataID;

@property (strong, atomic) NSArray* parkingLots;
@property (strong, atomic) NSArray* areas;
+(id) sharedInstance;
/*
 ADDRESS = "\U677f\U6a4b\U5340\U4e2d\U5c71\U8def\U4e00\U6bb5152\U865f";
 AREA = "\U677f\U6a4b\U5340";
 ID = 010056;
 NAME = "\U9060\U6771\U767e\U8ca8\U505c\U8eca\U5834";
 PAYEX = "\U5c0f\U578b\U8eca\U8a08\U664260\U5143;";
 SERVICETIME = "0~24\U6642";
 SUMMARY = "\U7acb\U9ad4\U5f0f\U5efa\U7bc9\U9644\U8a2d\U505c\U8eca\U7a7a\U9593";
 TEL = "";
 TOTALBIKE = "";
 TOTALCAR = 453;
 TOTALMOTOR = 0;
 TW97X = 296882;
 TW97Y = 2767068;
 TYPE = 2;
 */
-(void) listAllData:(void(^)(NSArray* data)) completionHandler;
-(void) listDataWithArea:(NSString*) area completionHandler:(void(^)(NSArray* data)) completionHandler;





@end

NS_ASSUME_NONNULL_END
