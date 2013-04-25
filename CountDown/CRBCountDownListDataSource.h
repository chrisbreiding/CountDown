//
//  CRBCountDownListDataSource.h
//  CountDown
//
//  Created by CB on 04/22/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRBCountDown;

@protocol CRBCountDownListDataSource <NSObject>

- (NSInteger)countDownCount;
- (CRBCountDown *)countDownAtIndex:(NSInteger)index;
- (NSInteger)indexOfCountDown:(CRBCountDown *)countDown;
- (void)deleteCountDownAtIndex:(NSInteger)index;
- (CRBCountDown *)createCountDown;
- (void)countDownsChanged;

@end