//
//  LibrarySearchDelegate.m
//  LibrarySearch
//
//  Created by Saikrishna Rao on 12/10/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "LibrarySearchDelegate.h"


@implementation LibrarySearchDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *searchResult = self.searchResults[indexPath.row];
    cell.textLabel.text = searchResult;
    cell.detailTextLabel.text = @"Sai";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

@end
