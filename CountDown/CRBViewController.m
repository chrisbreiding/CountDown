//
//  CRBViewController.m
//  CountDown
//
//  Created by CB on 04/11/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBViewController.h"
#import "CRBCountDownEditorViewController.h"
#import "CRBCountDown.h"

@interface CRBViewController ()

- (void)setUpSwipeHandlers;

- (void)didSwipeUp:(UISwipeGestureRecognizer *)sender;
- (void)didSwipeDown:(UISwipeGestureRecognizer *)sender;
- (void)didSwipeLeft:(UISwipeGestureRecognizer *)sender;
- (void)didSwipeRight:(UISwipeGestureRecognizer *)sender;

- (void)tryUpdatingCountBy:(int)amount;
- (void)updateCount;

@end

@implementation CRBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSwipeHandlers];
}

- (void)viewWillAppear:(BOOL)animated {
    self.title = [self.countDown name];
    self.daysLeftLabel.text = [NSString stringWithFormat:@"%@", [self.countDown daysLeft]];    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"editExistingCountDown" isEqualToString:segue.identifier]) {
        UIViewController *topVC = [[segue destinationViewController] topViewController];
        CRBCountDownEditorViewController *editor = (CRBCountDownEditorViewController *)topVC;
        editor.delegate = self;
        editor.countDown = self.countDown;
    }
}

- (void)setUpSwipeHandlers {
    UISwipeGestureRecognizer *didSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp:)];
    [didSwipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [[self view] addGestureRecognizer:didSwipeUp];
    
    UISwipeGestureRecognizer *didSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown:)];
    [didSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:didSwipeDown];
    
    UISwipeGestureRecognizer *didSwipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    [didSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:didSwipeLeft];
    
    UISwipeGestureRecognizer *didSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    [didSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:didSwipeRight];
}

- (void)didSwipeUp:(UISwipeGestureRecognizer *)sender {
    [self tryUpdatingCountBy:10];
}

- (void)didSwipeDown:(UISwipeGestureRecognizer *)sender {
    [self tryUpdatingCountBy:-10];
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)sender {
    [self tryUpdatingCountBy:-1];
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)sender {
    [self tryUpdatingCountBy:1];
}

- (void)tryUpdatingCountBy:(int)amount {
    int newCount = [[self.countDown daysLeft] intValue] + amount;
    if (newCount >= 0) {
        [self.countDown setDaysLeft:@(newCount)];
        [self updateCount];
    }
}

- (void)updateCount {
    self.daysLeftLabel.text = [NSString stringWithFormat:@"%@", [self.countDown daysLeft]];
    [self.delegate countDownChanged:self.countDown];
}

#pragma mark - Edit View Delegate Methods

- (void)countDownChanged:(CRBCountDown *)countDown {
    self.title = countDown.name;
    [self.delegate countDownChanged:countDown];
    [self.dataSource countDownsChanged];    
}

- (void)editCancelled:(CRBCountDown *)countDown {
}

@end
