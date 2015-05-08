//
//  ContainerViewController.h
//  LeftScrolingApp
//
//  Created by Saikrishna Rao on 11/19/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "ViewController.h"

@interface ContainerViewController : UIViewController

-(instancetype) initWithLeftViewController: (UIViewController *) leftViewController mainViewController:(UIViewController *) mainViewController gap:(NSInteger) gap;

@end
