//
//  CRBCountDownListViewController.m
//  CountDown
//
//  Created by CB on 04/22/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBCountDownListViewController.h"
#import "CRBViewController.h"
#import "CRBCountDownEditorViewController.h"
#import "CRBCountDown.h"

@implementation CRBCountDownListViewController

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource countDownCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"countdown";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CRBCountDown *countDown = [self.dataSource countDownAtIndex:indexPath.row];
    cell.textLabel.text = [countDown name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ days left", [countDown daysLeft]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataSource deleteCountDownAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }   
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([@"presentCountDownDetail" isEqualToString:segue.identifier]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CRBCountDown *countDown = [self.dataSource countDownAtIndex:indexPath.row];
        UIViewController *destination = [segue destinationViewController];
        CRBViewController *vc = (CRBViewController *)destination;
        vc.delegate = self;
        vc.countDown = countDown;
    }
    
    if([@"addNewCountDown" isEqualToString:segue.identifier]) {
        CRBCountDown *countDown = [self.dataSource createCountDown];
        UIViewController *topVC = [[segue destinationViewController] topViewController];
        CRBCountDownEditorViewController *editor = (CRBCountDownEditorViewController *)topVC;
        editor.delegate = self;
        editor.countDown = countDown;
    }
}

#pragma mark - Edit View Delegate Methods

- (void)countDownChanged:(CRBCountDown *)countDown {
    [self.dataSource countDownsChanged];
    NSUInteger row = [self.dataSource indexOfCountDown:countDown];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self.tableView insertRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)editCancelled:(CRBCountDown *)countDown {
    [self.dataSource deleteCountDownAtIndex:[self.dataSource indexOfCountDown:countDown]];
}

@end
