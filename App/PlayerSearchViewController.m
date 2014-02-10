//
//  PlayerSearchViewController.m
//  App
//
//  Created by Sai krishna K Rao on 2/9/14.
//  Copyright (c) 2014 Sai krishna K Rao. All rights reserved.
//

#import "PlayerSearchViewController.h"
#import "PlayerSearchTableCell.h"
#import "TTPlayer.h"
#import "SVProgressHUD.h"

@interface PlayerSearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *playerSearchResults;
@property (weak, nonatomic) IBOutlet UISearchBar *playerSearch;
@property (strong, nonatomic) TableTennisInformationService *ttInfoSvc;
@property (strong, nonatomic) NSMutableArray *searchResults;
@end

@implementation PlayerSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Player Search";
        self.ttInfoSvc = [[TableTennisInformationService alloc] init];
        self.searchResults = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"PlayerSearchCell" bundle:nil];
    [self.playerSearchResults registerNib:cellNib forCellReuseIdentifier:@"PlayerCell"];
    
    //[self.playerSearchResults registerClass:[PlayerSearchTableCell class] forCellReuseIdentifier:@"PlayerCell"];
    //self.playerSearchResults.userInteractionEnabled = NO;
    self.ttInfoSvc.dataDelegate = self;
    
   // [self.playerSearchResults registerClass:[PlayerSearchTableCell class] forCellReuseIdentifier:@"PlayerCell"];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //self.playerSearchResults.tableHeaderView = self.playerSearch;
}
-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"SearchBar Search Button Clicked %@",    searchBar.text);
    NSString *searchStr = searchBar.text;
    [self.ttInfoSvc searchPlayer:searchStr];
    //[SVProgressHUD showWithStatus:@"Searching"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResults count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTPlayer *player = (TTPlayer *)[ self.searchResults objectAtIndex:indexPath.row];
     NSLog(@"Player Name %@",    player.name);
    PlayerSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
    cell.imageView.image = [UIImage imageNamed:@"Player"];
    cell.imageView.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = player.name;
    return cell;
}

-(void) didRecieveTableTennisPlayerformation:(NSArray *) data andError:(NSError  *) error{
    [self.searchResults removeAllObjects];
    [self.searchResults addObjectsFromArray:data];
    //[SVProgressHUD dismiss];
    NSLog(@"Data Was recieved %d", [self.searchResults count]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.playerSearchResults reloadData];
    });

}

@end
