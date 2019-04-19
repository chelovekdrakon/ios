//
//  MainViewController.m
//  RSSchool_T4
//
//  Created by Фёдор on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    subview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:subview];
    [subview release];
}

@end
