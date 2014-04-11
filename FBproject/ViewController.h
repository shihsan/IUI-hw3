//
//  ViewController.h
//  FBproject
//
//  Created by Amy on 2014/3/31.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UIImageView+AFNetworking.h"

@interface ViewController : UIViewController <FBLoginViewDelegate>
{
    NSArray *friendarray;
}

@property (strong, nonatomic) IBOutlet FBLoginView *loginView;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;


@end