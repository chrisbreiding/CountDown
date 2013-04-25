//
//  CRBCountDownEditorDelegate.h
//  CountDown
//
//  Created by CB on 04/23/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRBCountDown;

@protocol CRBCountDownEditorDelegate <NSObject>

- (void)countDownChanged:(CRBCountDown *)countDown;
- (void)editCancelled:(CRBCountDown *)countDown;

@end