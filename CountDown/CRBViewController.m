//
//  CRBViewController.m
//  CountDown
//
//  Created by CB on 04/11/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBViewController.h"

@interface CRBViewController ()

@property (strong, nonatomic) UILabel *countdownLabel;
@property (nonatomic) NSInteger count;

- (void)setViewStyles;
- (void)setUpCountLabel;
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
    [self setViewStyles];
    [self setUpCountLabel];
    [self setUpSwipeHandlers];
}

- (void)setViewStyles {
    self.view.backgroundColor = [UIColor colorWithRed:0.745 green:0.745 blue:0.094 alpha:1.0];
}

- (void)setUpCountLabel {
    _countdownLabel = [[UILabel alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _countdownLabel.textAlignment = NSTextAlignmentCenter;
    _countdownLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _countdownLabel.font = [UIFont systemFontOfSize:90];
    _countdownLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_countdownLabel];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *countString = [userDefaults objectForKey:@"CountDown"];
    if (countString == (id)[NSNull null] || countString.length == 0 ) {
        countString = @"0";
    }
    _countdownLabel.text = countString;
    _count = [countString intValue];
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
    int newCount = _count + amount;
    if (newCount >= 0) {
        _count = newCount;
        [self updateCount];
    }
}

- (void)updateCount {
    NSString *countString = [NSString stringWithFormat:@"%d", _count];
    _countdownLabel.text = countString;    

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:countString forKey:@"CountDown"];
}

@end
