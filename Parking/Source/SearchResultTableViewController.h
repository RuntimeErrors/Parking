//
//  SearchResultTableViewController.h
//  Parking
//
//  Created by 蔡維昌 on 2019/7/16.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchResultDelegate <NSObject>
@required
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void) didSelectItem:(NSString *)name;
@end


@interface SearchResultTableViewController : UITableViewController
@property (atomic, strong) id<SearchResultDelegate> delegate;
@property (nonatomic, copy) NSString *filterString;
@property (copy) NSArray *allResults;
@property NSInteger searchBarScopeIndex;
@end

NS_ASSUME_NONNULL_END
