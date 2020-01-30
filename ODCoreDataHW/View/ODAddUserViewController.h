//
//  ODAddUserViewController.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODDataManager.h"
#import "ODDataViewControllerTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODAddUserViewController : UITableViewController
@property (strong, nonatomic)  UITextField *lastName;
@property (strong, nonatomic)  UITextField *firstName;
@property (strong, nonatomic)  UITextField *email;


- (IBAction)randomButton:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@property (strong, nonatomic) ODUser* user; 



@end

NS_ASSUME_NONNULL_END
