//
//  AppDelegate.h
//  FBproject
//
//  Created by Amy on 2014/3/31.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"
#import "MenuViewController.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *ViewController;
@property (strong, nonatomic) MenuViewController *MenuViewController;
@property (strong, nonatomic) MainViewController *MainViewController;

@end
