//
//  PlayerSearchViewController.h
//  App
//
//  Created by Sai krishna K Rao on 2/9/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableTennisInformationServiceDelegate.h"
#import "TableTennisInformationService.h"

@interface PlayerSearchViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,TableTennisInformationServiceDelegate>

@end
