//
//  CRBViewController.h
//  CountDown
//
//  Created by CB on 04/11/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBCountDown.h"
#import "CRBCountDownEditorDelegate.h"
#import "CRBCountDownListDataSource.h"

@interface CRBViewController : UIViewController <CRBCountDownEditorDelegate>

@property(nonatomic, weak) id<CRBCountDownEditorDelegate> delegate;
@property(nonatomic, strong) id <CRBCountDownListDataSource> dataSource;
@property (nonatomic, strong)CRBCountDown *countDown;
@property (nonatomic, strong) IBOutlet UILabel *daysLeftLabel;

@end
