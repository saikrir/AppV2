//
//  NewArticleContentViewController.m
//  App
//
//  Created by Sai krishna K Rao on 1/20/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "SVProgressHUD.h"
#import "NewsArticleContentViewController.h"

@interface NewsArticleContentViewController ()
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *articleSegment;
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
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeBlack];
    self.view.layer.borderWidth = 0.5;
    self.view.layer.borderColor = [[UIColor blackColor] CGColor];
    [self loadOfflineHTMLPage];
}

-(void) viewDidLayoutSubviews{
    // Resizing code
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


-(void) loadOfflineHTMLPage
{
    NSString *htmlContent = [self generateHTML];
    [self.webView loadHTMLString:htmlContent baseURL:nil];
    [self.webView sizeToFit];
}

-(void) loadOnlineArticle{
    NSString *articleURLLink = self.newsArticle.link;
    NSURL *articleURL = [NSURL URLWithString:articleURLLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:articleURL];
    [self.webView loadRequest:request];
}

- (IBAction)handleArticleViewToggle:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSUInteger selectedIndex = [segmentedControl selectedSegmentIndex];
    [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeBlack];
    NSURL *resetURL = [NSURL URLWithString:@"about:blank"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:resetURL ]];
    
    if(selectedIndex == 0){
        [self loadOfflineHTMLPage];
    }
    else{
        [self loadOnlineArticle];
    }
}


-(NSString *) generateHTML
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Template" ofType:@"html"];
 
    NSError *error = nil;
    
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error: &error];
    
    if(! error){
        
        NSString *title = self.newsArticle.title;
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"#title#" withString:title];
        
        NSString *link = self.newsArticle.imageURL;
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"#link#" withString:link];
        
        NSString *content = self.newsArticle.description;
        htmlString = [htmlString stringByReplacingOccurrencesOfString:@"#content#" withString:content];
    }
    
    return htmlString;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    
     [self.webView sizeToFit];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
