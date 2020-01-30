//
//  ODAddCourseViewController.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODAddCourseViewController.h"
#import "ODTeacherViewController.h"
#import "ODUserViewControlle.h"
#import "ODAddUserViewController.h"

@interface ODAddCourseViewController ()

@property (strong, nonatomic) UITextField* nameField;
@property (strong, nonatomic) UIButton* addTeacher;
@property (strong, nonatomic) UILabel* teacherLable;

@property (strong, nonatomic) NSString* courseName;
@property (assign, nonatomic) BOOL goBack;
@property (strong, nonatomic) NSFetchedResultsController* fetchResult;
@property (strong, nonatomic) NSArray* allUser;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;



@end


@implementation ODAddCourseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tabBarController.delegate = self;
    self.goBack = YES;
    if (self.course) {
        self.teacher = self.course.teacher;
        self.navigationItem.title = [NSString stringWithFormat:@"Course %@", self.course.name ];
        self.allUser = [[ODDataManager sharedManager] allUsers];
        
    } else{
        self.navigationItem.title = @"Add course";
    }
    
    
}


- (NSManagedObjectContext*) managedObjectContext {
    
    if (!_managedObjectContext) {
        _managedObjectContext = [[ODDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"About course";
    } else if (section == 1){
        return @"Course users";
    } else{
        return nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSUInteger row = 0;
    if (section == 0) {
        row = 2;
    }
    if (section == 1) {
        row = [self.course.user count]+1;
    }
    return row;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
     
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Course Name";
        if (!self.nameField) {
            self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, 250, 45)];
            if (self.course.name) {
                self.nameField.text = self.course.name;
            }
            
            [cell.contentView addSubview:self.nameField];
        }
        
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Teacher";
   
    
            if ((!self.course.teacher) && !self.teacher) {
                self.addTeacher = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                self.addTeacher.frame = CGRectMake(150, 0, 100, 45);
                [self.addTeacher  setTitle:@"Add teacher" forState:UIControlStateNormal];
                [self.addTeacher addTarget:self action:@selector(addTeacherCourse) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView insertSubview:self.addTeacher atIndex:1];
                
            }else{
                if (self.teacherLable) {
                    [self.teacherLable removeFromSuperview];
                }
                self.teacherLable = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 250, 45)];
                
                self.teacherLable.text = [NSString stringWithFormat:@"%@ %@", self.teacher.firstName, self.teacher.lastName];
                [self.addTeacher removeFromSuperview];
                [cell.contentView insertSubview:self.teacherLable atIndex:1];
            }
    }
        
    } if (indexPath.section == 1) {
        
        if (indexPath.row ==0) {
            cell.textLabel.text = @"Add user in course";
            cell.textLabel.textColor = [UIColor greenColor];
            cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
        } else{
        
        ODUser *user = (ODUser*)[[self.course.user allObjects] objectAtIndex:indexPath.row-1];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && indexPath.section == 0) {
        [self addTeacherCourse];
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        [self addUserInCourse];
    } else if (indexPath.section == 1){
        
        ODUser *user = (ODUser*)[[self.course.user allObjects] objectAtIndex:indexPath.row-1];
        UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
        ODAddUserViewController* vc = (ODAddUserViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ODAddUserViewController"];
        
        vc.user = user; 
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == 1 && indexPath.row > 0) {
        return YES;
    } else{
    return NO;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{

    NSLog(@"%@ course name", self.nameField.text);
    self.courseName = self.nameField.text;
    if (![self.nameField.text isEqualToString:@""]) {
        [self saveContext];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ODUser* removeUser = (ODUser*)[[self.course.user allObjects] objectAtIndex:indexPath.row - 1];
        [self.course removeUserObject:removeUser];
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
        } else{
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

#pragma mark - Add methods

-(void) addTeacherCourse{
    UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
    ODTeacherViewController* vc = (ODTeacherViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ODTeacherViewController"];

        vc.course = self.course;
        vc.delegate = self;
        self.goBack = NO;

    [self.navigationController pushViewController:vc animated:YES];

}

-(void) addUserInCourse{
    
    self.goBack = NO;
    ODUserViewControlle* vc = (ODUserViewControlle*)[self.tabBarController.viewControllers objectAtIndex:1];
    vc.addUserForCourse = YES;
    vc.course = self.course;
    [self saveContext];
    [self.tabBarController setSelectedIndex:1];
}

-(void) saveContext{
    if (self.goBack) {
        
        if (!self.course) {
         self.course = [[ODDataManager sharedManager] saveCourseWithName:self.nameField.text courceTeacher: self.teacher];
        } else{
        self.course.name = self.nameField.text;
        self.course.teacher = self.teacher;
        }
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
           }
    }
  
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   
    if (tabBarController.selectedIndex == 1) {
        [self addUserInCourse];
  
    }
}


#pragma mark - ODTeacherDelegate

-(void) selectTeacher:(ODTeacher *)teacher foreCourse:(ODCourse *)course nameCourse:(NSString *)courseName{
    self.teacher = teacher;
    if (courseName) {
        self.courseName = courseName;
    }
    if (course) {
        self.course = course;
    }
    self.goBack = YES;
}



@end
