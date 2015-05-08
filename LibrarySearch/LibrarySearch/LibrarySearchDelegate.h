//
//  LibrarySearchDelegate.h
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/10/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LibrarySearchDelegate : NSObject<UITableViewDataSource>
    @property (nonatomic,strong) NSArray *searchResults;
@end
