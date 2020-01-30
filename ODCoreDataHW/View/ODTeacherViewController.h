//
//  ODTeacherViewController.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODDataViewControllerTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ODTeacherDelegate;

@interface ODTeacherViewController : ODDataViewControllerTableViewController



@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (strong, nonatomic) ODCourse* course;
@property (weak, nonatomic) id <ODTeacherDelegate> delegate;

@end

@protocol ODTeacherDelegate <NSObject>

-(void) selectTeacher:(ODTeacher*) teacher foreCourse:(ODCourse*) course nameCourse:(NSString*) courseName;

@end

NS_ASSUME_NONNULL_END
