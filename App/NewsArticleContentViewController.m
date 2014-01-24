//
//  NewArticleContentViewController.m
//  App
//
//  Created by Sai krishna K Rao on 1/20/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "NewsArticleContentViewController.h"

@interface NewsArticleContentViewController ()
@property (nonatomic,weak) IBOutlet UIWebView *myView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@end

@implementation NewsArticleContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   
    self.view.layer.borderWidth = 0.5;
    self.view.layer.borderColor = [[UIColor blackColor] CGColor];
    
    NSString *link = self.newsArticle.link;
    
    NSURL *articleURL = [NSURL URLWithString:link];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:articleURL];
    
    [self.myView loadRequest: request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
