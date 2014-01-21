//
//  NewArticleViewCell.m
//  App
//
//  Created by Sai krishna K Rao on 1/12/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "NewArticleViewCell.h"

@implementation NewArticleViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


-(void) setImage:(UIImage *) image{
    self.articleThumbNailView.image = image;
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.0;
    self.titleLabel.text = @"Saikrishna";

    [self setNeedsLayout];
}

-(void) setDefaultImage
{
    self.articleThumbNailView.image = [UIImage imageNamed:@"PlaceHolder"];
    [self setNeedsLayout];
}

- (void)setup
{
    [self.articleThumbNailView removeFromSuperview];
    [self.backgroundView addSubview:self.articleThumbNailView];
    
    int width = CGRectGetWidth(self.frame);
    int height = CGRectGetHeight(self.frame);
    
    CGSize sz = [self.newsArticle.title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2, height/3, sz.width, sz.height)];
    self.titleLabel.text = self.newsArticle.title;
    [self addSubview:self.titleLabel];
   // [self.contentView addSubview:self.titleLabel];

    
}

@end
