//
//  ViewController.m
//  LeftScrolingApp
//
//  Created by Saikrishna Rao on 11/9/14.
//  Copyright (c) 2014 Saikrishna Rao. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}
- (IBAction)handleTap:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *leftNav = [storyBoard instantiateViewControllerWithIdentifier:@"LefNav"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = leftNav;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"My Cell";
    if(indexPath.row %2 != 0){
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

@end
