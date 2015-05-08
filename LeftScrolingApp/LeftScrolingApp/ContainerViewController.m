//
//  ContainerViewController.m
//  LeftScrolingApp
//
//  Created by Saikrishna Rao on 11/19/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *mainViewController;
@property (nonatomic, assign) NSInteger gap;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ContainerViewController


-(instancetype) initWithLeftViewController: (UIViewController *) leftViewController mainViewController:(UIViewController *) mainViewController gap:(NSInteger) gap{
 
    self = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        self.mainViewController = mainViewController;
        self.gap = gap;
        
        [self setupScrollView];
        [self setupViewControllers];
    }
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}

-(void) setupScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    NSDictionary *views = @{
                            @"scrollView": self.scrollView
                            };
    NSString *vFmt = @"|[scrollView]|";
    
    NSArray *hzContraints = [NSLayoutConstraint constraintsWithVisualFormat:vFmt options:0 metrics:nil views:views];
    [self.view addConstraints:hzContraints];
    
    vFmt = @"V:|[scrollView]|";
    NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:vFmt options:0 metrics:nil views:views];
    [self.view addConstraints:vContraints];
    
}

-(void) setupViewControllers{
    
    self.leftViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.leftViewController.view];
    [self addChildViewController:self.leftViewController];
    [self.leftViewController didMoveToParentViewController:self];
    
    self.mainViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.mainViewController.view];
    [self addChildViewController:self.mainViewController];
    [self.mainViewController didMoveToParentViewController:self];
    
    
    NSDictionary *viewsDictionary = @{
        @"outerView" : self.scrollView,
        @"leftView": self.leftViewController.view,
        @"mainView": self.mainViewController.view
    };
    
    /*
    NSString *fmt = @"|[leftNav][mainView(==container)]|";
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:fmt options:0 metrics:nil views:views]];
    
    NSLayoutConstraint *contraint = [NSLayoutConstraint constraintWithItem:self.leftViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-self.gap];
    
    [self.view addConstraint:contraint];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftNav(==container)]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView(==container)]|" options:0 metrics:nil views:views]];*/
    
    NSArray *horzConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|[leftView][mainView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:horzConstraints];
    
    NSLayoutConstraint *leftViewWidth = [NSLayoutConstraint constraintWithItem:self.leftViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant: -self.gap];
    [self.view addConstraint:leftViewWidth];
    
    NSArray *leftViewVertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:leftViewVertConstraints];
    
    NSArray *mainViewVertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView(==outerView)]|" options:0 metrics:nil views:viewsDictionary];
    [self.view addConstraints:mainViewVertConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLayoutSubviews{
    
    CGPoint offsetPt = self.scrollView.contentOffset;
    offsetPt.x = CGRectGetWidth(self.view.bounds) - self.gap;
    
    self.scrollView.contentOffset = offsetPt;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
