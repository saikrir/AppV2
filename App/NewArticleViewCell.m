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
        self.articleThumbNailView = [[UIImageView alloc] initWithFrame:self.bounds]; // earlier it was frame
        [self.contentView addSubview:self.articleThumbNailView];
    }
    return self;
}

-(void) setImage:(UIImage *) image{
     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.clipsToBounds = YES;
    self.backgroundView = imageView;
    self.backgroundView.clipsToBounds = YES;
    [self setNeedsLayout];
}

-(void) setDefaultImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlaceHolder"]];
    self.backgroundView = imageView;
    [self setNeedsLayout];
}

- (void)setup
{
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0.7 alpha:1] CGColor];
}

@end
