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
        //self.contentView.layer.borderWidth = 1.0f;
        //self.contentView.layer.borderColor = [UIColor yellowColor].CGColor;
    }
    return self;
}


-(void) setImage:(UIImage *) image{
    self.articleThumbNailView.image = image;
}


-(void) setDefaultImage
{
    self.articleThumbNailView.image = [UIImage imageNamed:@"PlaceHolder"];
    [self setNeedsLayout];
}

- (void)setup
{
//    [self.articleThumbNailView removeFromSuperview];
  //  [self.backgroundView addSubview:self.articleThumbNailView];
    [self.articleLabel removeFromSuperview];
    [self.contentView addSubview:self.articleLabel];
}

@end
