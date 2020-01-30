//
//  UserViewControlle.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODUserViewControlle.h"
#import "ODAddUserViewController.h"

@interface ODUserViewControlle ()

@end

@implementation ODUserViewControlle

@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Users";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ODUser"
                inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
     NSSortDescriptor* nameDescription =
     [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
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
    
    ODUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ - %@", user.firstName, user.lastName, user.email ];
    cell.detailTextLabel.text = nil;    
    if (self.addUserForCourse) {
        if ([self.course.user containsObject:user]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ODUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.addUserForCourse) {

    if ([self.course.user containsObject:user]) {
        [self.course removeUserObject:user];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        [self.course addUserObject:user];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
           }
    }
    else{
    
    
    UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
    ODAddUserViewController* vc = (ODAddUserViewController*)[storyboard instantiateViewControllerWithIdentifier:@"ODAddUserViewController"];
    
    vc.user = user;
    
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (IBAction)deleteAllUser:(id)sender {
    [[ODDataManager sharedManager] deleteAllUsers];
}
@end
