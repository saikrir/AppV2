
#import "MainViewController.h"
#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"
#import "NewArticleViewCell.h"
#import "NewsArticleContentViewController.h"
#import "NewArticleViewTransition.h"
#import "NewArticleContentDismissTransition.h"


@interface MainViewController(){
    NSMutableArray *newsArticles;
}

@property (nonatomic, strong) TableTennisNewsArticleReader *newsArticleReader;
@property (nonatomic, strong) NSURLSession *thumbNailSession;
@property (nonatomic, weak) IBOutlet UICollectionView *thumbNailsView;
@end

@implementation MainViewController

NSString *const url= @"http://www.teamusa.org/USA-Table-Tennis/Features?count=100&rss=";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"Table Tennis News";
        newsArticles = [[NSMutableArray alloc] initWithCapacity:50];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [newsArticles removeAllObjects];
    
    UINib *cellNib = [UINib nibWithNibName:@"NewsArticleThumbNail" bundle:nil];
    
    [self.thumbNailsView registerClass:[NewArticleViewCell class] forCellWithReuseIdentifier:@"thumbNailCell"];
    [self.thumbNailsView registerNib:cellNib forCellWithReuseIdentifier:@"thumbNailCell"];
    self.thumbNailsView.pagingEnabled = YES;
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150, 130)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.thumbNailsView setCollectionViewLayout:flowLayout];
    self.thumbNailsView.backgroundColor = [UIColor whiteColor];
    
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.thumbNailSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    self.newsArticleReader = [[TableTennisNewsArticleReader alloc] initWithReaderURL:url];
    self.newsArticleReader.newsArticleDelegate = self;
    [self.newsArticleReader readNewsArticles];
    [SVProgressHUD showWithStatus:@"Loading.." maskType:SVProgressHUDMaskTypeBlack];
}


#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%d",  [newsArticles count] );
    return [newsArticles count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewArticleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thumbNailCell" forIndexPath:indexPath];
    NewsArticle *newsArticle = (NewsArticle *)[newsArticles objectAtIndex:indexPath.row];
    [cell setDefaultImage];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newsArticle.imageURL ]];
    
    NSURLSessionDataTask *thumbNailTask = [self.thumbNailSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
             UIImage *image = [UIImage imageWithData:data];
            [cell setImage:image];
        });
    }];
    
    [thumbNailTask resume];
    
    
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsArticle *newsArticle = (NewsArticle *)[newsArticles objectAtIndex:indexPath.row];
    
    NewsArticleContentViewController *newsArticleContentVC = [[NewsArticleContentViewController alloc] initWithNibName:@"NewsArticleContentViewController" bundle:nil];
    newsArticleContentVC.newsArticle = newsArticle;
    newsArticleContentVC.modalPresentationStyle = UIModalPresentationCustom;
    newsArticleContentVC.transitioningDelegate = self;
    
    [self presentViewController:newsArticleContentVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRecieveNewsArticle:(NSArray *)news andError:(NSError *)error
{
    NSLog(@"Data Recieved");
    [newsArticles addObjectsFromArray:news];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [SVProgressHUD dismiss];
        [self.thumbNailsView reloadData];
    }];
}


#pragma Mark - Transition Deleagtes

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    NewArticleViewTransition *transition = [[NewArticleViewTransition alloc] init];
    return transition;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    NewArticleContentDismissTransition *dismissTransition = [[NewArticleContentDismissTransition alloc] init];
    return dismissTransition;
}

@end