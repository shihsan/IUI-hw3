//
//  TableViewController.m
//  FBproject
//
//  Created by Amy on 2014/4/5.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

//@synthesize logoutView;
//@synthesize profilepic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //logoutView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"user_events"]];
    //logoutView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
