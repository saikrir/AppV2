//
//  NewArticleViewCell.h
//  App
//
//  Created by Sai krishna K Rao on 1/12/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewArticleViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *articleThumbNailView;

-(void) setDefaultImage;
-(void) setImage:(UIImage *) image;
@end
