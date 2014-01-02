//
//  MainViewController.h
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticleDelegate.h"
#import "NewsArticleReader.h"

@interface MainViewController : UIViewController<UITabBarDelegate, UITableViewDataSource,NewsArticleDelegate>

@end
