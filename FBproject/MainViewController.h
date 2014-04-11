//
//  MainViewController.h
//  FBproject
//
//  Created by Amy on 2014/4/8.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UIImageView+AFNetworking.h"

@interface MainViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,FBLoginViewDelegate,FBFriendPickerDelegate,UISearchBarDelegate>
{
    NSMutableArray *list;
    NSString *Fname, *Lname, *user_id, *gender, *locale, *link;
    NSInteger info_count;
    NSMutableArray *friendsarray;
}

@property (strong, nonatomic) IBOutlet UITableView *Mytable;
@property (strong, nonatomic) IBOutlet UIImageView *cover_photo;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *Profile_photo;
@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UIButton *post_btn;

@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (strong, nonatomic) IBOutlet UIButton *pick_btn;
@property (strong, nonatomic) IBOutlet UITextView *selectedFriends;

@property (retain, nonatomic) UISearchBar *searchBar;
@property (retain, nonatomic) NSString *searchText;
@end
