//
//  FilesViewController.h
//  gistrunner
//
//  Created by Kirk Kaiser on 3/20/15.
//  Copyright (c) 2015 zothcorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) NSDictionary *files;
@end
