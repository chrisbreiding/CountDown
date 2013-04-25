//
//  CRBCountDownListViewController.h
//  CountDown
//
//  Created by CB on 04/22/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBCountDownListDataSource.h"
#import "CRBCountDownEditorDelegate.h"

@interface CRBCountDownListViewController : UITableViewController <CRBCountDownEditorDelegate>

@property(nonatomic, strong) id <CRBCountDownListDataSource> dataSource;

@end
