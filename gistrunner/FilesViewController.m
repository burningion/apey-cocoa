//
//  FilesViewController.m
//  gistrunner
//
//  Created by Kirk Kaiser on 3/20/15.
//  Copyright (c) 2015 zothcorp. All rights reserved.
//

#import "FilesViewController.h"
#import "DetailViewController.h"

@interface FilesViewController ()

@end

@implementation FilesViewController
@synthesize files;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return [[files allKeys] count];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"jump"]) {
        NSLog(@"we're in the segue");
        DetailViewController *detailController = (DetailViewController *)segue.destinationViewController;
        NSArray *keys = [files allKeys];
        
        detailController.gistUrl = files[keys[[sender integerValue]]][@"raw_url"];
        detailController.fileName = keys[[sender integerValue]];
    }
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
    NSArray *keys = [files allKeys];
    
    cell.textLabel.text = keys[indexPath.row];
    
    if ([files[keys[indexPath.row]][@"language"] isEqual:[NSNull null]]) {
        cell.detailTextLabel.text = @"Unspecified Language";
    }
    else {
        cell.detailTextLabel.text = files[keys[indexPath.row]][@"language"];
    }
                                                    
    return cell;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *selected = [NSNumber numberWithInteger:indexPath.row];
    [self performSegueWithIdentifier:@"jump" sender:selected];
    return indexPath;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
