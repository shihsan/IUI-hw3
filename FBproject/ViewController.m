//
//  ViewController.m
//  FBproject
//
//  Created by Amy on 2014/3/31.
//  Copyright (c) 2014年 bobo. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize loginView;
@synthesize profilePictureView;
@synthesize nameLabel;
@synthesize statusLabel;
@synthesize Fname;
@synthesize Lname;
@synthesize link;

@synthesize request_btn;
@synthesize post_btn;

//NSString *profileid;
@synthesize swipelabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"user_events"]];
    loginView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.id;
    self.nameLabel.text = user.name;
    self.Fname.text = user.first_name;
    self.Lname.text = user.last_name;
    self.link.text = user.link;
    //profileid = user.id;
    [self performSegueWithIdentifier: @"login" sender:self];
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    [self.request_btn setHidden:NO];
    [self.post_btn setHidden:NO];
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
    self.Fname.text = @"";
    self.Lname.text = @"";
    self.link.text = @"";
    
    [self.request_btn setHidden:YES];
    [self.post_btn setHidden:YES];
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (IBAction)requestEvents:(id)sender
{
    // We will request the user's events
    // These are the permissions we need:
    NSArray *permissionsNeeded = @[@"user_events"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  NSDictionary *currentPermissions= [(NSArray *)[result data] objectAtIndex:0];
                                  NSLog(@"current permissions %@", currentPermissions);
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:@[]];
                                  
                                  // Check if all the permissions we need are present in the user's current permissions
                                  // If they are not present add them to the permissions to be requested
                                  for (NSString *permission in permissionsNeeded){
                                      if (![currentPermissions objectForKey:permission]){
                                          [requestPermissions addObject:permission];
                                      }
                                  }
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession requestNewReadPermissions:requestPermissions
                                                                       completionHandler:^(FBSession *session, NSError *error) {
                                                                           if (!error) {
                                                                               // Permission granted
                                                                               NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                                                                               // We can request the user information
                                                                               [self makeRequestForUserEvents];
                                                                           } else {
                                                                               // An error occurred, we need to handle the error
                                                                               // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                                                               NSLog(@"error %@", error.description);
                                                                           }
                                                                       }];
                                  } else {
                                      // Permissions are present
                                      // We can request the user information
                                      [self makeRequestForUserEvents];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  NSLog(@"error %@", error.description);
                              }
                          }];

}

- (void)makeRequestForUserEvents
{
    [FBRequestConnection startWithGraphPath:@"me?fields=cover"
completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if (!error) {
        // Success! Include your code to handle the results here
        NSLog([NSString stringWithFormat:@"user events: %@", result]);
        
        //NSDictionary *params = [self parseURLParams:result];
        //NSLog([NSString stringWithFormat:@"params: %@", params]);

        
        
    } else {
        // An error occurred, we need to handle the error
        // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
        NSLog([NSString stringWithFormat:@"error %@", error.description]);
    }
}];
}


//------------------Posting a status update using the share dialog------------------
- (IBAction)postStatusUpdateWithShareDialog:(id)sender
{
    
    // Check if the Facebook app is installed and we can present the share dialog
    
    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:nil
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:nil
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User cancelled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User cancelled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}



// A function for parsing URL parameters
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login"]) {
        TableViewController *destViewController = segue.destinationViewController;
        //destViewController.logoutView = self.loginView;
        //destViewController.profilepic.profileID = profileid;

        //NSIndexPath *selectedIndexPath = self.loginView ;//self.tableView.indexPathForSelectedRow;
        //destViewController.idRest =[bd.idrestauracao objectAtIndex:selectedIndexPath.row];
    }
}
*/


@end
