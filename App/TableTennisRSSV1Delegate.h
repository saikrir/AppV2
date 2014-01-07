//
//  TableTennisRSSV1Delegate.h
//  App
//
//  Created by Sai krishna K Rao on 1/2/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsArticle.h"
#import "TableTennisRSSBaseReader.h"


@interface TableTennisRSSV1Delegate : TableTennisRSSBaseReader
    @property (nonatomic, strong) NSMutableArray *newsArticles;
@end
