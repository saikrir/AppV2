//
//  NewArticleViewTransition.m
//  App
//
//  Created by Sai krishna K Rao on 1/20/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "NewArticleViewTransition.h"

@implementation NewArticleViewTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    CGRect mainRect = fromVC.view.frame;
    
    toVC.view.frame = CGRectMake(20,CGRectGetHeight(mainRect) + 20, CGRectGetWidth(mainRect)-20, CGRectGetHeight(mainRect)-20);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5f initialSpringVelocity:0.6f options:0 animations:^{
        toVC.view.frame = CGRectMake(20, 20, CGRectGetWidth(mainRect)-40, CGRectGetHeight(mainRect)-40);
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
