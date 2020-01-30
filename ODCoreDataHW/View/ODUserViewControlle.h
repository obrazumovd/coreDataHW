//
//  ODUserViewControlle.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODDataViewControllerTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODUserViewControlle : ODDataViewControllerTableViewController
- (IBAction)deleteAllUser:(id)sender;
@property (assign, nonatomic) BOOL addUserForCourse;
@property (strong, nonatomic) ODCourse* course;

@end

NS_ASSUME_NONNULL_END
