//
//  MainViewController.m
//  App
//
//  Created by Sai krishna K Rao on 12/29/13.
//  Copyright (c) 2013 Sai krishna K Rao. All rights reserved.
//

#import "MainViewController.h"
#import "TableTennisNewsArticleReader.h"

@interface MainViewController (){
    NSMutableArray *newsArticles;
}
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *newsLoadingIndicator;

    @property (weak, nonatomic) IBOutlet UITableView *newsView;
    @property (strong, nonatomic) id<NewsArticleReader> newsArticleReader;
@end

@implementation MainViewController

NSString *const url= @"http://tabletennista.com/rss?page=1";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"News Articles";
        self.navigationItem.title = @"Table Tennis News";
        self.newsArticleReader = [[TableTennisNewsArticleReader alloc] initWithReaderURL:url];
        self -> newsArticles = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.newsLoadingIndicator startAnimating];
    [self.newsArticleReader readNewsArticles];
    
    self.newsLoadingIndicator.hidesWhenStopped = YES;
    ((TableTennisNewsArticleReader *)self.newsArticleReader).newsArticleDelegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma Mark - NewsArticle Delegate Methds

-(void) didRecieveNewsArticle:(NSArray *)news andError:(NSError *)error
{
    [newsArticles addObjectsFromArray:news];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.newsLoadingIndicator stopAnimating];
        [self.newsView reloadData];
    });
    
}

#pragma Mark - TableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [newsArticles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *cellValue = [[newsArticles objectAtIndex:indexPath.row] title];
    cell.textLabel.text = cellValue;
    return cell;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint offset = scrollView.contentOffset;
    UIEdgeInsets inset = scrollView.contentInset;
    CGSize scrollSize = scrollView.contentSize;
    
    float dist = offset.y + CGRectGetHeight(scrollView.bounds) - inset.bottom;
    
    float scrollTolerance = 44;
    
    if(dist > scrollSize.height + scrollTolerance){
        
        // Todo Load More
        
    }

}



@end
