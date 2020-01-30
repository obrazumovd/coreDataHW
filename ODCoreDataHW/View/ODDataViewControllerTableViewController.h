//
//  ODDataViewControllerTableViewController.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ODDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODDataViewControllerTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*) indexPath;

- (NSFetchedResultsController *)fetchedResultsControllerEntityName:(NSString*) entityName sortDescription:(NSArray*) SortDescription;
@end

NS_ASSUME_NONNULL_END
