//
//  NewArticleContentViewController.h
//  App
//
//  Created by Sai krishna K Rao on 1/20/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticle.h"

@protocol QuickViewDelegate <NSObject>
-(void) didDismissQuickViewWith:(NewsArticle *) article;
@end

@interface NewsArticleContentViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong) NewsArticle *newsArticle;
@property (nonatomic,strong) id<QuickViewDelegate> delegate;

@end
