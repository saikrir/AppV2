//
//  MyView.m
//  LearningViews
//
//  Created by Saikrishna Rao on 11/29/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "MyView.h"

@interface MyView ()

@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MyView

-(void) setup{
    NSLog(@"Setup called");
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}


-(void) awakeFromNib{
    [self setup];
}

- (void)drawRect:(CGRect)rect {
    
    self.imageView.clipsToBounds = YES;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:35];
    [bezierPath addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [bezierPath stroke];
    
}


@end
