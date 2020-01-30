//
//  ODAddTeacherViewController.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 26.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODAddTeacherViewController.h"

@interface ODAddTeacherViewController ()

@property (strong, nonatomic) UITextField* firstName;
@property (strong, nonatomic) UITextField* lastName;



@end

@implementation ODAddTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Add teacher";
  
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"First Name";
        self.firstName = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, 100, 45)];
        if (self.teacher) {
            self.firstName.text = self.teacher.firstName;
        }
        [cell addSubview: self.firstName];
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Last Name";
        self.lastName = [[UITextField alloc] initWithFrame:CGRectMake(150, 0, 100, 45)];
        if (self.teacher) {
            self.lastName.text = self.teacher.lastName;
        }
        [cell addSubview: self.lastName];
    }
 
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self saveContext];
    
}

-(void) saveContext{
    if (self.teacher) {
        [[ODDataManager sharedManager] deleteObject:self.teacher];
        
    }
    if (![self.firstName.text isEqualToString:(@"")] && ![self.lastName.text isEqualToString:(@"")]) {
        [[ODDataManager sharedManager] saveTeacherWithFirstName:self.firstName.text withLastName:self.lastName.text];
    }
    
}
@end
