//
//  ArticleWebViewController.m
//  App
//
//  Created by Sai krishna K Rao on 2/3/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "ArticleWebViewController.h"
#import "SVProgressHUD.h"

@interface ArticleWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;

@end

@implementation ArticleWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.articleWebView.delegate = self;
    self.articleWebView.scalesPageToFit = YES;
    self.title = self.newsArticle.title;
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *articleUrl = self.newsArticle.link;
    NSURL *url = [NSURL URLWithString:articleUrl];
    [self.articleWebView loadRequest:[NSURLRequest requestWithURL:url]];
    [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeBlack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
}

@end
