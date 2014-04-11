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
@synthesize statusLabel;


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
    /*self.nameLabel.text = user.name;
    self.Fname.text = user.first_name;
    self.Lname.text = user.last_name;
    self.link.text = user.link;*/
    //profileid = user.id;
    
    //透過segue id = "login" 轉場至 MenuViewController
    [self performSegueWithIdentifier: @"login" sender:self];
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    /*[self.request_btn setHidden:NO];
    [self.post_btn setHidden:NO];*/
    
    /* request for cover */
    /*// We will request the user's events
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
   */
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.statusLabel.text= @"You're not logged in!";

    /*self.nameLabel.text = @"";
    self.Fname.text = @"";
    self.Lname.text = @"";
    self.link.text = @"";
    
    [self.request_btn setHidden:YES];
    [self.post_btn setHidden:YES];*/
    
    [self dismissViewControllerAnimated:YES completion:^{}];


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

/*
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
*/
 
/*
- (void)makeRequestForUserEvents
{
    [FBRequestConnection startWithGraphPath:@"me?fields=cover"
completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    if (!error) {
        // Success! Include your code to handle the results here
        NSLog([NSString stringWithFormat:@"user events: %@", result[@"cover"][@"source"]]);
        
        
        //NSDictionary *params = [self parseURLParams:result];
        //NSLog([NSString stringWithFormat:@"params: %@", params]);

        
        
    } else {
        // An error occurred, we need to handle the error
        // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
        NSLog([NSString stringWithFormat:@"error %@", error.description]);
    }
}];
}
*/

/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login"]) {
        MenuViewController *destViewController = segue.destinationViewController;
        //destViewController.profilepic.profileID = profileid;

        //NSIndexPath *selectedIndexPath = self.loginView ;//self.tableView.indexPathForSelectedRow;
        //destViewController.idRest =[bd.idrestauracao objectAtIndex:selectedIndexPath.row];
    }
}
*/

@end
