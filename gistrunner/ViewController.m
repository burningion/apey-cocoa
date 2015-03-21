//
//  ViewController.m
//  gistrunner
//
//  Created by Kirk Kaiser on 3/20/15.
//  Copyright (c) 2015 zothcorp. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "FilesViewController.h"

#import <AFNetworking/AFNetworking.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *theGistList;
@end

@implementation ViewController
@synthesize gists, theGistList;


- (void)loadGists {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"https://api.github.com/gists/public?limit=30" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
    
        self.gists = responseObject;
        [self.theGistList reloadData];
        //NSLog(@"number of gists: %lu", (unsigned long)[self.gists count]);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadGists];
    [refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.theGistList addSubview:refreshControl];
    [self loadGists];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [gists count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Latest Public Gists";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }

    NSString *name = @"Anonymous";
    
    if ([gists isEqual:[NSNull null]]) {
        return cell;
    }
    if ([gists[indexPath.row][@"description"] isEqual:[NSNull null]]) {
        name = @"No Description";
    }
    else if ([gists[indexPath.row][@"description"] length] > 0) {
         name = gists[indexPath.row][@"description"];
    }
    
    
    NSString *languages = @"Unknown";
    
    if ([gists[indexPath.row][@"files"] isEqual:[NSNull null]]) {
        name = @"No File";
    }
    else if ([gists[indexPath.row][@"files"] count] > 0) {
        NSArray *keys = [gists[indexPath.row][@"files"] allKeys];
        // NSLog(@"%@", gists[indexPath.row][@"files"][keys[0]][@"language"]);
        
        if ([gists[indexPath.row][@"files"][keys[0]][@"language"] isEqual:[NSNull null]]) {
            languages = @"Unspecified";
        }
        else {
            languages = [NSString stringWithFormat:@"Language: %@, Number of Files: %lu", gists[indexPath.row][@"files"][keys[0]][@"language"], (unsigned long)[keys count]];
        }
    }
        
    cell.textLabel.text = name;
    cell.detailTextLabel.text = languages;
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"jump"]) {
        NSLog(@"we're in the jump segue");
        DetailViewController *detailController = (DetailViewController *)segue.destinationViewController;
        NSArray *keys = [gists[[sender integerValue]][@"files"] allKeys];
        detailController.gistUrl = gists[[sender integerValue]][@"files"][keys[0]][@"raw_url"];
        detailController.fileName = keys[0];
        NSLog(@"everything got set");
    }
    else if ([segue.identifier isEqualToString:@"hop"]) {
        NSLog(@"we're in the hop segue");
        FilesViewController *filesController = (FilesViewController *)segue.destinationViewController;
        filesController.files = gists[[sender integerValue]][@"files"];
    }

}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *selected = [NSNumber numberWithInteger:indexPath.row];
    NSArray *keys = [gists[indexPath.row][@"files"] allKeys];
    if ([keys count] > 1) {
        [self performSegueWithIdentifier:@"hop" sender:selected];
    }
    else {
        [self performSegueWithIdentifier:@"jump" sender:selected];
    }
    return indexPath;
}

@end
