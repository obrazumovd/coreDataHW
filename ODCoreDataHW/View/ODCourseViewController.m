//
//  ODCourseViewController.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODCourseViewController.h"
#import "ODAddCourseViewController.h"

@interface ODCourseViewController ()

@end

@implementation ODCourseViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = @"Course";
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ODCourse"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
     NSSortDescriptor* nameDescription =
     [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
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
    
    ODCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name ];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[course.user allObjects] count]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ODCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
    UITabBarController* tb = (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"CourseTabBarController"];
    ODAddCourseViewController* vc = (ODAddCourseViewController*)[tb.viewControllers objectAtIndex:0];
    vc.course = course;
    [tb setSelectedViewController:vc];

    

    [self.navigationController pushViewController:tb animated:YES];
    
}

@end
