//
//  NewArticleViewCell.m
//  App
//
//  Created by Sai krishna K Rao on 1/12/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "NewsArticleViewCell.h"

@implementation NewsArticleViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setup];
        NSString *frmStr = NSStringFromCGRect(frame);
        NSLog(@"WTF %@", frmStr);
        //self.contentView.layer.borderWidth = 1.0f;
        //self.contentView.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    return self;
}


-(void) setImage:(UIImage *) image{
    
    self.backgroundColor = [UIColor grayColor];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.articleLabel.text = self.newsArticle.title;
    self.articleThumbNailView.image = image;
    self.articleThumbNailView.clipsToBounds = YES;
    
    CALayer *imgViewLayer = self.articleThumbNailView.layer;
    
    imgViewLayer.borderWidth = 1;
    imgViewLayer.masksToBounds = NO;
    imgViewLayer.shadowOffset = CGSizeMake(5.0, 5.0);
    imgViewLayer.shadowRadius = 8.0;
    imgViewLayer.shadowOpacity = 0.8;
}


-(void) setDefaultImage
{
    self.articleThumbNailView.image = [UIImage imageNamed:@"PlaceHolder"];
}

- (void)setup
{
//    [self.articleThumbNailView removeFromSuperview];
  //  [self.backgroundView addSubview:self.articleThumbNailView];
}

@end
