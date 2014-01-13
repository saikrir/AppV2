
#import "MainViewController.h"
#import "TableTennisNewsArticleReader.h"
#import "NewsArticle.h"
#import "NewArticleViewCell.h"

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
    [self.thumbNailsView registerClass:[NewArticleViewCell class] forCellWithReuseIdentifier:@"thumbNailCell"];
    self.thumbNailsView.pagingEnabled = YES;
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
    NSLog(@"cellForIndex called");
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thumbNailCell" forIndexPath:indexPath];
    NewArticleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thumbNailCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setImage:@"PlaceHolder"];
    return cell;
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

@end