//
//  ViewController.h
//  FBproject
//
//  Created by Amy on 2014/3/31.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "TableViewController.h"

@interface ViewController : UIViewController <FBLoginViewDelegate>


@property (strong, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *Fname;
@property (strong, nonatomic) IBOutlet UILabel *Lname;
@property (strong, nonatomic) IBOutlet UILabel *link;

@property (strong, nonatomic) IBOutlet UIButton *request_btn;
@property (strong, nonatomic) IBOutlet UIButton *post_btn;

@property (strong, nonatomic) IBOutlet UILabel *swipelabel;

@end