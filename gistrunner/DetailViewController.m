//
//  DetailViewController.m
//  gistrunner
//
//  Created by Kirk Kaiser on 3/20/15.
//  Copyright (c) 2015 zothcorp. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *fileTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webbyView;

@end

@implementation DetailViewController

@synthesize fileTitle, webbyView, gistUrl, fileName;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", fileName);
    NSLog(@"%@", gistUrl);
    fileTitle.topItem.title = fileName;
    NSURL *theURL = [NSURL URLWithString:gistUrl];
    NSURLRequest *theRequest  = [NSURLRequest requestWithURL:theURL];
    webbyView.contentMode = UIViewContentModeScaleAspectFit;
    webbyView.scalesPageToFit = YES;
    [webbyView loadRequest:theRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
