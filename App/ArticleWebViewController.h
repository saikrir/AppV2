//
//  ArticleWebViewController.h
//  App
//
//  Created by Sai krishna K Rao on 2/3/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticle.h"


@interface ArticleWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) NewsArticle *newsArticle;

@end
