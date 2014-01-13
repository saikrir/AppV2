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
        NSLog(@"Inited");
        self.articleThumbNailView = [[UIImageView alloc] initWithFrame:self.bounds]; // earlier it was frame
        [self.contentView addSubview:self.articleThumbNailView];
    }
    return self;
}

-(void) setImage:(NSString *) name
{
    //
    self.articleThumbNailView.image = [UIImage imageNamed:name];
    [self setNeedsLayout];
}

@end
