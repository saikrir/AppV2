//
//  ViewController.m
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/10/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "ViewController.h"
#import "LibrarySearchDelegate.h"
#import "LibrarySearch.h"
#import "DetailsViewController.h"

@interface ViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchResults;
@property (strong,nonatomic) NSMutableArray *tutorialEntries;
@property (strong, nonatomic) LibrarySearchDelegate *searchDatasource;
@property (strong,nonatomic) NSMutableArray *libResults;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

NSString *const cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchResults registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.searchDatasource = [[LibrarySearchDelegate alloc] init];
    self.searchResults.dataSource = self.searchDatasource;
    self.libResults = [[NSMutableArray alloc] init];
    [self.activityIndicator stopAnimating];
}

#pragma mark - SearchBar Delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.libResults removeAllObjects];
    NSString *searchStr = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(searchStr.length < 3){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Results"
                                                            message: @"Please enter atleast 3 characters"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [searchBar resignFirstResponder];
    [self.activityIndicator startAnimating];
    [[LibrarySearch instance] searchFor:searchStr completionHandler:^(NSArray *searchResults, NSError *error) {
    
        if(!error){
            
            [self.libResults addObjectsFromArray:searchResults];
            NSMutableArray *newEntries = [[NSMutableArray alloc] initWithCapacity:[searchResults count]];
            [searchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSString *entry = (NSString *) obj;
                [newEntries addObject: [entry lastPathComponent]];
            }];
            
            self.searchDatasource.searchResults = newEntries;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.searchResults reloadData];
                if([searchResults count] == 0){
                    [self resetSearchState:@"No Search Results found"];
                }else{
                    self.searchResults.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.frame));
                }
            });
        }
        else{
            [self resetSearchState:[NSString stringWithFormat:@"Failed to connect to server" ]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
        });
        
    }];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    [self performSegueWithIdentifier:@"detailsView" sender:nil];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
   NSIndexPath *indexPath = self.searchResults.indexPathForSelectedRow;
    DetailsViewController *destinationViewController = [segue destinationViewController];
    destinationViewController.selectedTopic = self.libResults[indexPath.row];
}

-(void) resetSearchState:(NSString *) messageText{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Search Results"
                                                        message: messageText
                                                       delegate:nil cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    self.searchBar.text = @"";
    [self.searchBar becomeFirstResponder];
 
}

@end
