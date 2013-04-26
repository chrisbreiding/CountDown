//
//  CRBEditCountDownViewController.h
//  CountDown
//
//  Created by CB on 04/23/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBCountDownEditorDelegate.h"

@class CRBCountDown;

@interface CRBCountDownEditorViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, weak) id<CRBCountDownEditorDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIImageView *nameFieldBackground;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UILabel *nameValidationField;
@property (nonatomic, strong) CRBCountDown *countDown;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end
