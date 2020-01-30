//
//  ODTeacherViewController.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODTeacherViewController.h"
#import "ODAddTeacherViewController.h"
#import "ODAddCourseViewController.h"

@interface ODTeacherViewController ()

@property (assign, nonatomic) BOOL isEditing;
@property (strong, nonatomic) UIBarButtonItem* editButton;

@end

@implementation ODTeacherViewController

@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Teacher";
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    [self.navigationItem setRightBarButtonItems:@[self.addButton, self.editButton]];
    self.isEditing = NO;
    
    
    
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ODTeacher"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
     NSSortDescriptor* lastNameDescription =
     [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor* firstNameDescription =
    [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     
    [fetchRequest setSortDescriptors:@[lastNameDescription, firstNameDescription]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
        
    ODTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.lastName, teacher.firstName ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[teacher.course allObjects] count]];
    if (self.course.teacher == teacher) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        

    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ODTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
    if (self.isEditing) {
           ODAddTeacherViewController * vc = (ODAddTeacherViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ODAddTeacherViewController"];
            vc.teacher = teacher;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        ODTeacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.delegate selectTeacher:teacher foreCourse:self.course nameCourse:@"tesT"];
       [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - Action
- (void)editAction{
    if (self.isEditing) {
        self.isEditing = NO;
        self.editButton.title = @"Edit";
    }else{
        self.isEditing = YES;
        self.editButton.title = @"Done";
    }

}
@end
