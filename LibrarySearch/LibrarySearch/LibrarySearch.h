//
//  LibrarySearch.h
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/11/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibrarySearch : NSObject

+(instancetype) instance;

-(void) searchFor:(NSString *) searchStr completionHandler:(void (^)(NSArray *searchResults, NSError *error)) completionHandler;

-(void) listingFor:(NSString *) topic completionHandler:(void (^)(NSArray *listingResults, NSError *error)) completionHandler;

@end
