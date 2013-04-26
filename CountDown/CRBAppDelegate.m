//
//  CRBAppDelegate.m
//  CountDown
//
//  Created by CB on 04/11/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBAppDelegate.h"
#import "CRBCountDownListViewController.h"
#import "CRBCountDownDocument.h"

@interface CRBAppDelegate ()

- (void)setAppearance;

@end

@implementation CRBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setAppearance];
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    CRBCountDownListViewController *controller = (CRBCountDownListViewController *)navigationController.topViewController;
    NSURL *docDir = [[[NSFileManager defaultManager]
                      URLsForDirectory:NSDocumentDirectory
                      inDomains:NSUserDomainMask] lastObject];
    NSURL *docURL = [docDir URLByAppendingPathComponent:@"CountDowns.countDowns"];
    CRBCountDownDocument *doc = [[CRBCountDownDocument alloc] initWithFileURL:docURL];
    controller.dataSource = doc;
    [doc openWithCompletionHandler:^(BOOL success) {
        if(success) {
            [controller.tableView reloadData];
        } else {
            NSLog(@"Failed to open document");
        }
    }];
    
    return YES;
}

- (void)setAppearance {
    UIImage *navBarImage = [[UIImage imageNamed:@"navigationbar.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    UIImage *barButton = [[UIImage imageNamed:@"bar-button.png"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 5)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setBackgroundImage:barButton
     forState:UIControlStateNormal
     barMetrics:UIBarMetricsDefault];

    UIImage *barBackButton = [[UIImage imageNamed:@"bar-back-button.png"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 5)];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setBackButtonBackgroundImage:barBackButton
     forState:UIControlStateNormal
     barMetrics:UIBarMetricsDefault];
}

@end
