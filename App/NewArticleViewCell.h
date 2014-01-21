//
//  NewArticleViewCell.h
//  App
//
//  Created by Sai krishna K Rao on 1/12/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsArticle.h"

@interface NewArticleViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articleThumbNailView;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NewsArticle *newsArticle;

-(void) setDefaultImage;
-(void) setImage:(UIImage *) image;
@end
