//
//  ODAddTeacherViewController.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODAddTeacherViewController : UITableViewController

@property (strong, nonatomic) ODTeacher* teacher;
@end

NS_ASSUME_NONNULL_END
