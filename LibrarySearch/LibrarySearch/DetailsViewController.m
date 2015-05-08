//
//  DetailsViewController.m
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/13/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "DetailsViewController.h"
#import "LibrarySearch.h"

@interface DetailsViewController ()

@property (nonatomic, strong) NSArray *listings;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [self.selectedTopic lastPathComponent];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detailCell"];
}


-(void) viewWillAppear:(BOOL)animated{
    
    [[LibrarySearch instance] listingFor:self.selectedTopic completionHandler:^(NSArray *listingResults, NSError *error) {
        if(!error){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.listings = listingResults;
                [self.tableView reloadData];
            });
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Library Search"
                                        message:@"Encountered an Error"
                                       delegate:self cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil, nil] show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [super viewWillAppear:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.textLabel.text = self.listings[indexPath.row];
    return cell;
}




@end
