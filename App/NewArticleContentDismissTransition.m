//
//  NewArticleContentDismissTransition.m
//  App
//
//  Created by Sai krishna K Rao on 1/20/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "NewArticleContentDismissTransition.h"

@implementation NewArticleContentDismissTransition


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *contentVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect initFrame = [transitionContext initialFrameForViewController:contentVC];
    
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.8 animations:^{
            CGRect upFrame = CGRectMake(initFrame.origin.x, -40, initFrame.size.width, initFrame.size.height);
            contentVC.view.frame = upFrame;
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
            CGRect downFrame = CGRectMake(initFrame.origin.x, initFrame.size.height +20 , initFrame.size.width, initFrame.size.height);
            contentVC.view.frame = downFrame;
            contentVC.view.transform = CGAffineTransformMakeRotation(2);
        }];
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

}


@end
