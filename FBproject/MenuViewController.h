//
//  MenuViewController.h
//  FBproject
//
//  Created by Amy on 2014/4/8.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface MenuViewController : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet FBLoginView *logout;


@end
