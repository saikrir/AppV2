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
#import "SVProgressHUD.h"
#import "TableTennisInformationService.h"
#import "TableTennisInformationServiceDelegate.h"
#import "LocationInoDataDelegate.h"
#import "NewsArticleContentViewController.h"
#import "ArticleWebViewController.h"


@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate,NewsArticleDelegate,TableTennisInformationServiceDelegate,LocationInoDataDelegate, QuickViewDelegate>

@end
