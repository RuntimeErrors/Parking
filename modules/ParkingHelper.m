//
//  ParkingHelper.m
//  Test API
//
//  Created by 蔡維昌 on 2019/7/15.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import "ParkingHelper.h"
static ParkingHelper* mParkingHelper = NULL;

@implementation ParkingHelper
+(id) sharedInstance
{
    if(mParkingHelper == NULL)
    {
        mParkingHelper = [[ParkingHelper alloc] init];
    }
    return mParkingHelper;
}
-(id) init
{
    self = [super init];
    self.parkingLots = @[];
    return self;
}
-(void)listAllData:(void (^)(NSArray * _Nonnull))completionHandler
{
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSString *urlStr = [NSString stringWithFormat:@"https://%@%@%@?$format=json", self.host, self.basePath, self.dataID];
    NSString *encodeUrl = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURL *url = [NSURL URLWithString:encodeUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];

    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Error: %@",error);

        
        NSError* jsonError;
        NSData *objectData = [[NSString stringWithUTF8String:[data bytes]] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:objectData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&jsonError];
        
        self.parkingLots = [[NSArray alloc] initWithArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(self.parkingLots);
            NSMutableDictionary* aerasDir = [[NSMutableDictionary alloc] init];
            
            //Upart areas
            for (NSDictionary* info in array) {
                [aerasDir setObject:info[@"AREA"] forKey:info[@"AREA"]];
            }
            self.areas = [aerasDir allKeys];
        
        });
        
    }];
    [dataTask resume];
}

-(void) listDataWithArea:(NSString*) area completionHandler:(void(^)(NSArray* data)) completionHandler
{
    NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
    NSString *urlStr = [NSString stringWithFormat:@"https://%@%@%@?$format=json&$filter=AREA eq %@", self.host, self.basePath, self.dataID, area];
    NSString *encodeUrl = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:encodeUrl];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Error: %@",error);
        
        
        NSError* jsonError;
        NSData *objectData = [[NSString stringWithUTF8String:[data bytes]] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
        
        self.parkingLots = [[NSArray alloc] initWithArray:array];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(self.parkingLots);
            NSMutableDictionary* aerasDir = [[NSMutableDictionary alloc] init];
            
            //Upart areas
            for (NSDictionary* info in array) {
                [aerasDir setObject:info[@"AREA"] forKey:info[@"AREA"]];
            }
            self.areas = [aerasDir allKeys];
            
        });
        
    }];
    [dataTask resume];
}
@end
