//
//  CRBEditCountDownViewController.m
//  CountDown
//
//  Created by CB on 04/23/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBCountDownEditorViewController.h"
#import "CRBCountDown.h"

@implementation CRBCountDownEditorViewController

#pragma mark - View Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameField.text = self.countDown.name;
    [self.nameField becomeFirstResponder];
}

#pragma mark - Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *trimmedName = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (trimmedName != nil && ![trimmedName isEqual: @""] ) {
        self.countDown.name = trimmedName;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate countDownChanged:self.countDown];
        return YES;
    } else {
        self.nameValidationField.hidden = NO;
        return NO;
    }
}

#pragma mark - IB Actions

- (IBAction)done:(id)sender {
    NSString *trimmedName = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (trimmedName != nil && ![trimmedName isEqual: @""] ) {
        self.countDown.name = trimmedName;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate countDownChanged:self.countDown];
    } else {
        self.nameValidationField.hidden = NO;
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate editCancelled:self.countDown];
}

@end
