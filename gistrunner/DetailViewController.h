//
//  DetailViewController.h
//  gistrunner
//
//  Created by Kirk Kaiser on 3/20/15.
//  Copyright (c) 2015 zothcorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) NSString *gistUrl;
@property (weak, nonatomic) NSString *fileName;
@property (weak, nonatomic) NSDictionary *gist;
@end
