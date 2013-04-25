//
//  CRBCountDownDocument.m
//  CountDown
//
//  Created by CB on 04/23/13.
//  Copyright (c) 2013 CB. All rights reserved.
//

#import "CRBCountDownDocument.h"
#import "CRBCountDown.h"

@interface CRBCountDownDocument ()

@property (nonatomic, strong)NSMutableArray *countDowns;

@end

@implementation CRBCountDownDocument

- (id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    if (self) {
        id value = nil;
        NSError *error = nil;
        if(![url getResourceValue:&value
                           forKey:NSURLAttributeModificationDateKey
                            error:&error]) {
            [self saveToURL:url
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              if(!success) {
                  NSLog(@"Failed to create file");
              }
          }];
        }
    }
    return self;
}

#pragma mark - Persistence Methods

- (BOOL)loadFromContents:(id)contents
                  ofType:(NSString *)typeName
                   error:(NSError **)outError {
    BOOL success = NO;
    if([contents isKindOfClass:[NSData class]] && [contents length] > 0) {
        NSData *data = (NSData *)contents;
        self.countDowns = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        success = YES;
    }
    return success;
}

- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
    return [NSKeyedArchiver archivedDataWithRootObject:self.countDowns];
}

- (void)handleError:(NSError *)error
userInteractionPermitted:(BOOL)userInteractionPermitted {
    if([[error domain] isEqualToString:NSCocoaErrorDomain] &&
       [error code] == NSFileReadNoSuchFileError) {
        [self saveToURL:[self fileURL]
       forSaveOperation:UIDocumentSaveForCreating
      completionHandler:^(BOOL success) {
          // ignore it here, we just wanted to make sure the document is created
          NSLog(@"handled open error with a new doc");
      }];
    } else {
        // if it's not a NSFileReadNoSuchFileError just call super
        [super handleError:error
  userInteractionPermitted:userInteractionPermitted];
    }
}

#pragma mark - CountDown Delegate Methods

- (NSMutableArray *)countDowns {
    if(!_countDowns) {
        self.countDowns = [NSMutableArray array];
    }
    return _countDowns;
}

- (CRBCountDown *)createCountDown {
    CRBCountDown *countDown = [[CRBCountDown alloc] init];
    [self.countDowns addObject:countDown];
    [self updateChangeCount:UIDocumentChangeDone];
    return countDown;
}

- (NSInteger)countDownCount {
    return [self.countDowns count];
}

- (CRBCountDown *)countDownAtIndex:(NSInteger)index {
    return [self.countDowns objectAtIndex:index];
}

- (NSInteger)indexOfCountDown:(CRBCountDown *)countDown  {
    return [self.countDowns indexOfObject:countDown];
}

- (void)deleteCountDownAtIndex:(NSInteger)index {
    [self.countDowns removeObjectAtIndex:index];
    [self updateChangeCount:UIDocumentChangeDone];
}

- (void)countDownsChanged {
    [self updateChangeCount:UIDocumentChangeDone];
}

@end
