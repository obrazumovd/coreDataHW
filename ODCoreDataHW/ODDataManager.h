//
//  ODDataManager.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ODCoreDataHW+CoreDataModel.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface ODDataManager : NSObject <NSFetchedResultsControllerDelegate>

+(ODDataManager*) sharedManager;


@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//-(ODUser*) addRandomUser;
-(NSArray*) allUsers;
-(void) deleteAllUsers;
-(void) deleteUser:(ODUser*) user;
-(void) deleteObject:(id) object;

-(void) saveUserWithFirstName:(NSString*) firstName withLastName:(NSString*) lastName withEmail:(NSString*) email;
-(void) saveTeacherWithFirstName:(NSString*) firstName withLastName:(NSString*) lastName;
-(ODCourse*) saveCourseWithName:(NSString*) courseName  courceTeacher:(NSString*) teacher;
-(void) saveCourse:(ODCourse*) course;
-(void) saveUser:(ODUser*) user;
-(void) saveUser:(ODUser*) user withCourse:(ODCourse*) course context:(NSManagedObjectContext*) context;

-(void) deleteCourse:(ODCourse*) course;

@end

NS_ASSUME_NONNULL_END
